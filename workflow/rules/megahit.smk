rule assemble:
# works
    input:
       fw='../results/clean_reads/{sample}_R1.fq.gz',
       rv='../results/clean_reads/{sample}_R2.fq.gz',
    output:
        contigs='../results/megahit/{sample}.contigs.fa',
        check = "../results/check/{sample}.mh.done.txt",
    conda: 
        "../envs/megahit.yml"
    params:
        output_folder = "../results/megahit/",
        output_temp = "../results/megahit_temp"
    threads: 6
    shell:
        """
        mkdir -p ../results/megahit_temp/
   
        # megahit does not allow force overwrite, so each assembly needs to take place in it's own directory. 
        megahit -1 {input.fw} -2 {input.rv} \
        -t {threads} --continue -m 0.095 \
        --out-dir {params.output_temp}/{wildcards.sample} --presets meta-large \
        --out-prefix {wildcards.sample} && \
        mv {params.output_temp}/{wildcards.sample}/{wildcards.sample}.contigs.fa \
        {params.output_folder} && touch {output.check}
        """