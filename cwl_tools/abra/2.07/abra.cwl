#!/usr/bin/env cwl-runner

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
  doap: http://usefulinc.com/ns/doap#

$schemas:
- http://dublincore.org/2012/06/14/dcterms.rdf
- http://xmlns.com/foaf/spec/20140114.rdf
- http://usefulinc.com/ns/doap#

doap:release:
- class: doap:Version
  doap:name: abra
  doap:revision: 2.14
- class: doap:Version
  doap:name: cwl-wrapper
  doap:revision: 0.0.0

dct:creator:
- class: foaf:Organization
  foaf:name: Memorial Sloan Kettering Cancer Center
  foaf:member:
  - class: foaf:Person
    foaf:name: Ian Johnson
    foaf:mbox: mailto:johnsoni@mskcc.org

dct:contributor:
- class: foaf:Organization
  foaf:name: Memorial Sloan Kettering Cancer Center
  foaf:member:
  - class: foaf:Person
    foaf:name: Ian Johnson
    foaf:mbox: mailto:johnsoni@mskcc.org

cwlVersion: v1.0

class: CommandLineTool

baseCommand:
- /opt/common/CentOS_6/java/jdk1.8.0_25/bin/java

arguments:
# todo: correct mem reqs?
- -Xmx20g
- -Djava.io.tmpdir=/scratch
- -jar
- /opt/common/CentOS_6-dev/abra/2.07/abra2-2.07.jar
# todo: correct version?
#- /home/johnsoni/Innovation-Pipeline/vendor_tools/abra2-2.14.jar

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    ramMin: 20000
    coresMin: 8

doc: |
  None

inputs:

  threads:
    type: string
    inputBinding:
      prefix: --threads
      # todo: same as -t?

  input_bam:
    type: File
    inputBinding:
      prefix: --in
    secondaryFiles:
    - ^.bai

  reference_fasta:
    type: string
    inputBinding:
      prefix: --ref

  targets:
    type: File
    inputBinding:
      prefix: --targets
      # todo: same as -tr

  output_bam_filename:
    type: ['null', string]
    default: $( inputs.input_bam.basename.replace(".bam", "_abraIR.bam") )
    inputBinding:
      prefix: -o
      valueFrom: $( inputs.input_bam.basename.replace(".bam", "_abraIR.bam") )

  kmers:
    type: string?
    inputBinding:
      prefix: -k

  p:
    type: string?
    inputBinding:
      prefix: -p

outputs:

  bam:
    type: File
    outputBinding:
      glob: $( inputs.input_bam.basename.replace(".bam", "_abraIR.bam") )