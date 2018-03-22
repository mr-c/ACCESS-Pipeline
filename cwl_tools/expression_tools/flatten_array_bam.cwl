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
  doap:name: flatten-array-bam
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

class: ExpressionTool
requirements:
  - class: InlineJavascriptRequirement

inputs:

  bams:
    type:
      type: array
      items:
        type: array
        items: File
    secondaryFiles: ['^.bai']

outputs:

  output_bams:
    type:
      type: array
      items: File
    secondaryFiles: ['^.bai']

expression: |
  ${
    var samples = [];

    for (var i = 0; i < inputs.bams.length; i++) {
      for (var j = 0; j < inputs.bams[i].length; j++) {
        samples.push(inputs.bams[i][j])
      }
    }

    return { "output_bams": samples };
  }