library(argparse)
source("/home/aelamb/repos/irwg/iatlas-tool-cibersort/bin/CIBERSORT.R")

parser = ArgumentParser(description = 'Deconvolute tumor samples with CIBERSORT')

# required args
parser$add_argument(
    "--sig_matrix_file",
    type = "character",
    required = TRUE,
    help = "Path to reference matrix.")
parser$add_argument(
    "--mixture_file",
    type = "character",
    required = TRUE,
    help = "Path to mixture matrix.")

# optional argumennts
parser$add_argument(
    "--output_file",
    default = "./output_file.RDS",
    type = "character",
    help = "Path to output file.")
parser$add_argument(
    '--perm',
    default = 0,
    type = "integer",
    help = "No. permutations; set to >=100 to calculate p-values (default = 0)")
parser$add_argument(
    "--QN",
    action = "store_false",
    help = "Quantile normalization of input mixture (default = TRUE)")
parser$add_argument(
    "--absolute",
    action = "store_true",
    help = "Run CIBERSORT in absolute mode (default = FALSE)")
parser$add_argument(
    "--abs_method",
    default = "sig.score",
    type = "character",
    help = "If absolute is set to TRUE, choose method: 'no.sumto1' or 'sig.score'")

args <- parser$parse_args()

result_object <- CIBERSORT(
    args$sig_matrix_file,
    args$mixture_file,
    args$perm,
    args$QN,
    args$absolute,
    args$abs_method)


saveRDS(result_object, args$output_file)