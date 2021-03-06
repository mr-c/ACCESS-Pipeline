#!/usr/bin/env cwl-runner

cwlVersion: v1.0

class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
  run_tools:
    type:
      type: record
      fields:
        perl_5: string
        java_7: string
        java_8: string
        marianas_path: string
        trimgalore_path: string
        bwa_path: string
        arrg_path: string
        picard_path: string
        gatk_path: string
        abra_path: string
        fx_path: string
        fastqc_path: string?
        cutadapt_path: string?
        waltz_path: string

  title_file: File
  pool_a_bed_file: File
  pool_b_bed_file: File
  gene_list: File
  coverage_threshold: int
  waltz__min_mapping_quality: int
  reference_fasta: string
  reference_fasta_fai: string

  # Fingerprinting
  FP_config_file: File

  sample_directories: Directory[]
  A_on_target_positions: File
  B_on_target_positions: File
  noise__good_positions_A: File

  standard_bams:
    type:
      type: array
      items: File
  marianas_unfiltered_bams:
    type:
      type: array
      items: File
  marianas_simplex_duplex_bams:
    type:
      type: array
      items: File
  marianas_duplex_bams:
    type:
      type: array
      items: File

outputs:

  qc_pdf:
    type: File[]
    outputSource: qc_workflow_wo_waltz/qc_pdf

  all_fp_results:
    type: Directory
    outputSource: qc_workflow_wo_waltz/all_fp_results

  FPFigures:
    type: File
    outputSource: qc_workflow_wo_waltz/FPFigures

  noise_table:
    type: File
    outputSource: qc_workflow_wo_waltz/noise_table

  noise_by_substitution:
    type: File
    outputSource: qc_workflow_wo_waltz/noise_by_substitution

  noise_alt_percent:
    type: File
    outputSource: qc_workflow_wo_waltz/noise_alt_percent

  noise_contributing_sites:
    type: File
    outputSource: qc_workflow_wo_waltz/noise_contributing_sites

  umi_qc:
    type: File[]
    outputSource: qc_workflow_wo_waltz/umi_qc

steps:

  ##############
  # Waltz Runs #
  ##############

  waltz_workflow:
    run: ../waltz/waltz_workflow_all_bams.cwl
    in:
      title_file: title_file
      run_tools: run_tools
      pool_a_bed_file: pool_a_bed_file
      pool_b_bed_file: pool_b_bed_file
      gene_list: gene_list
      coverage_threshold: coverage_threshold
      waltz__min_mapping_quality: waltz__min_mapping_quality
      reference_fasta: reference_fasta
      reference_fasta_fai: reference_fasta_fai
      standard_bams: standard_bams
      marianas_unfiltered_bams: marianas_unfiltered_bams
      marianas_simplex_duplex_bams: marianas_simplex_duplex_bams
      marianas_duplex_bams: marianas_duplex_bams
    out: [
      waltz_standard_pool_a_files,
      waltz_unfiltered_pool_a_files,
      waltz_simplex_duplex_pool_a_files,
      waltz_duplex_pool_a_files,
      waltz_standard_pool_b_files,
      waltz_unfiltered_pool_b_files,
      waltz_simplex_duplex_pool_b_files,
      waltz_duplex_pool_b_files]

  #########################
  # QC workflow W/O Waltz #
  #########################

  qc_workflow_wo_waltz:
    run: ./qc_workflow_wo_waltz.cwl
    in:
      title_file: title_file
      FP_config_file: FP_config_file
      sample_directories: sample_directories
      A_on_target_positions: A_on_target_positions
      B_on_target_positions: B_on_target_positions
      noise__good_positions_A: noise__good_positions_A

      waltz_standard_pool_a: waltz_workflow/waltz_standard_pool_a_files
      waltz_unfiltered_pool_a: waltz_workflow/waltz_unfiltered_pool_a_files
      waltz_simplex_duplex_pool_a: waltz_workflow/waltz_simplex_duplex_pool_a_files
      waltz_duplex_pool_a: waltz_workflow/waltz_duplex_pool_a_files
      waltz_standard_pool_b: waltz_workflow/waltz_standard_pool_b_files
      waltz_unfiltered_pool_b: waltz_workflow/waltz_unfiltered_pool_b_files
      waltz_simplex_duplex_pool_b: waltz_workflow/waltz_simplex_duplex_pool_b_files
      waltz_duplex_pool_b: waltz_workflow/waltz_duplex_pool_b_files
    out: [
      qc_pdf,
      all_fp_results,
      FPFigures,
      noise_table,
      noise_by_substitution,
      noise_alt_percent,
      noise_contributing_sites,
      umi_qc]
