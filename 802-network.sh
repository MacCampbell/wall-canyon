#!/bin/bash

#SBATCH -p high
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=10:05:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=maccampbell@ucdavis.edu
#SBATCH --output=outputs/801/net.out # File to which STDOUT will be written
#SBATCH --error=outputs/801/net.err # File to which STDERR will be written


module load julia/1.8.2     

julia -p 8 802-network.jl
