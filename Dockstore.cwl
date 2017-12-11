#!/usr/bin/env cwl-runner
#
# Authors: Andrew Lamb

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [Rscript, /usr/local/bin/cibersort_wrapper.R]

doc: "run CIBERSORT"

requirements:
- class: InlineJavascriptRequirement

hints:
  DockerRequirement:
    dockerPull: quay.io/cri-iatlas/iatlas-tool-cibersort

inputs:

  sig_matrix_file:
    type: File
    inputBinding:
      prefix: --sig_matrix_file
    doc: Path to reference matrix.
    
  mixture_file:
    type: File
    inputBinding:
      prefix: --mixture_file
    doc: Path to mixture matrix.

  output_file_string:
    type: string
    default: "./output_file.tsv"
    inputBinding:
      prefix: --output_file
    doc: Path to write output file

  perm:
    type: ["null", int]
    inputBinding:
      prefix: --perm
    doc: No. permutations; set to >=100 to calculate p-values (default = 0)

  QN:
    type: ["null", boolean]
    inputBinding:
      prefix: --QN
    doc: "Quantile normalization of input mixture (default = TRUE)"

  absolute:
    type: ["null", boolean]
    inputBinding:
      prefix: --absolute
    doc: Run CIBERSORT in absolute mode (default = FALSE).

  abs_method:
    type: ["null", string]
    inputBinding:
      prefix: --abs_method
    doc: If absolute is set to TRUE, choose method 'no.sumto1' or 'sig.score'

outputs:

  output_file:
    type: File
    outputBinding:
      glob: $(inputs.output_file_string)
    doc: see output_string



