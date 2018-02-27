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
  doap:name: fulcrum.CollectDuplexSeqMetrics
  doap:revision: 0.5.0
- class: doap:Version
  doap:name: fulcrum.CollectDuplexSeqMetrics
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
- -Xms8g
- -Xmx8g
- -jar
- /home/johnsoni/Innovation-Pipeline/vendor_tools/fgbio-0.5.0.jar
- --tmp-dir=/scratch
- CollectDuplexSeqMetrics

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    ramMin: 10000
    coresMin: 1

doc: |
  None

inputs:
#  tmp_dir:
#    type: string
#    inputBinding:
#      prefix: --tmp_dir

  input_bam:
    type: File
    inputBinding:
      prefix: -i

  u:
    type: string
    default: 'true'
    inputBinding:
      prefix: -u
      valueFrom: ${ return 'true' }

  output_bam_filename:
    type: ['null', string]
    default: $( inputs.input_bam.basename.replace(".bam", "") )
    inputBinding:
      prefix: -o
      valueFrom: $( inputs.input_bam.basename.replace(".bam", "") )

outputs:

  metrics:
    type: File
    outputBinding:
      glob: '*.pdf'