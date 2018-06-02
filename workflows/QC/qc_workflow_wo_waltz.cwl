#!/usr/bin/env cwl-runner

cwlVersion: v1.0

class: Workflow

doc: |
  This workflow is intended to be used to test the QC module,
  without having to run the long waltz step

requirements:
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  title_file: File
  FP_config_file: File

  waltz_standard_pool_a: Directory
  waltz_unfiltered_pool_a: Directory
  waltz_simplex_duplex_pool_a: Directory
  waltz_duplex_pool_a: Directory
  waltz_standard_pool_b: Directory
  waltz_unfiltered_pool_b: Directory
  waltz_simplex_duplex_pool_b: Directory
  waltz_duplex_pool_b: Directory

outputs:

  qc_pdf:
    type: File[]
    outputSource: duplex_innovation_qc/qc_pdf

  all_fp_results:
    type: Directory
    outputSource: fingerprinting/all_fp_results

  FPFigures:
    type: File
    outputSource: fingerprinting/FPFigures

  noise_out:
    type: File[]
    outputSource: plot_noise/plots

steps:

  ########################################
  # Aggregate Bam Metrics across samples #
  # for each collapsing method           #
  ########################################

  standard_aggregate_bam_metrics_pool_a:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_standard_pool_a
    out:
      [output_dir]

  unfiltered_aggregate_bam_metrics_pool_a:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_unfiltered_pool_a
    out:
      [output_dir]

  simplex_duplex_aggregate_bam_metrics_pool_a:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_simplex_duplex_pool_a
    out:
      [output_dir]

  duplex_aggregate_bam_metrics_pool_a:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_duplex_pool_a
    out:
      [output_dir]

  standard_aggregate_bam_metrics_pool_b:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_standard_pool_b
    out:
      [output_dir]

  unfiltered_aggregate_bam_metrics_pool_b:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_unfiltered_pool_b
    out:
      [output_dir]

  simplex_duplex_aggregate_bam_metrics_pool_b:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_simplex_duplex_pool_b
    out:
      [output_dir]

  duplex_aggregate_bam_metrics_pool_b:
    run: ../../cwl_tools/python/aggregate_bam_metrics.cwl
    in:
      title_file: title_file
      waltz_input_files: waltz_duplex_pool_b
    out:
      [output_dir]

  ##################
  # Fingerprinting #
  ##################

  fingerprinting:
    run: ../../cwl_tools/python/fingerprinting.cwl
    in:
      output_directory:
        valueFrom: ${return '.'}
      waltz_directory: waltz_standard_pool_a
      FP_config_file: FP_config_file
    out: [
      all_fp_results,
      FPFigures
    ]

  #########
  # Noise #
  #########

  noise:
    run: ../../cwl_tools/noise/noise.cwl
    in:
      # Todo: Should be on Duplex A:
      waltz_directory: waltz_standard_pool_a
    out:
      [noise, noise_by_substitution]

  plot_noise:
    run: ../../cwl_tools/noise/plot_noise.cwl
    in:
      noise: noise/noise
      noise_by_substitution: noise/noise_by_substitution
    out:
      [plots]

  ###############
  # UMI Metrics #
  ###############

#  umi_metrics:
#    run: ../../cwl_tools/umi_metrics/make_umi_qc_tables.cwl
#    in:
#
#
#  umi_qc:
#    run: ../../cwl_tools/umi_metrics/umi_qc.cwl
#    in:


  #################
  # Innovation-QC #
  #################

  duplex_innovation_qc:
    run: ../../cwl_tools/python/innovation-qc.cwl
    in:
      title_file: title_file

      standard_waltz_metrics_pool_a: standard_aggregate_bam_metrics_pool_a/output_dir
      unfiltered_waltz_metrics_pool_a: unfiltered_aggregate_bam_metrics_pool_a/output_dir
      simplex_duplex_waltz_metrics_pool_a: simplex_duplex_aggregate_bam_metrics_pool_a/output_dir
      duplex_waltz_metrics_pool_a: duplex_aggregate_bam_metrics_pool_a/output_dir

      standard_waltz_metrics_pool_b: standard_aggregate_bam_metrics_pool_b/output_dir
      unfiltered_waltz_metrics_pool_b: unfiltered_aggregate_bam_metrics_pool_b/output_dir
      simplex_duplex_waltz_metrics_pool_b: simplex_duplex_aggregate_bam_metrics_pool_b/output_dir
      duplex_waltz_metrics_pool_b: duplex_aggregate_bam_metrics_pool_b/output_dir
    out:
      [qc_pdf]