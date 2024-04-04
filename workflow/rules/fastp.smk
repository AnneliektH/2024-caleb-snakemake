rule fastp:
    input:
        fw1 = "../results/raw_reads/{sample}_L005_R1_001.fastq.gz", 
        fw2 = "../results/raw_reads/{sample}_L006_R1_001.fastq.gz", 
        fw3 = "../results/raw_reads/{sample}_L007_R1_001.fastq.gz", 
        fw4 = "../results/raw_reads/{sample}_L008_R1_001.fastq.gz", 
        rv1 = "../results/raw_reads/{sample}_L005_R2_001.fastq.gz", 
        rv2 = "../results/raw_reads/{sample}_L006_R2_001.fastq.gz", 
        rv3 = "../results/raw_reads/{sample}_L007_R2_001.fastq.gz", 
        rv4 = "../results/raw_reads/{sample}_L008_R2_001.fastq.gz", 
    output:
        cat_fw = temporary("../results/raw_reads/{sample}_R1.fq.gz"),
        cat_rv = temporary("../results/raw_reads/{sample}_R2.fq.gz"),
        fw = "../results/clean_reads/{sample}_R1.fq.gz",
        rv = "../results/clean_reads/{sample}_R2.fq.gz",
        qual = "../results/clean_reads/{sample}.html"
    conda: 
        "../envs/fastp.yml"
    threads: 6
    shell:
        """
        cat {input.fw1} {input.fw2} {input.fw3} {input.fw4} > {output.cat_fw} && \
        cat {input.rv1} {input.rv2} {input.rv3} {input.rv4} > {output.cat_rv} && \
        fastp -i {output.cat_fw} \
        -I {output.cat_rv} \
        -o {output.fw} -O {output.rv} --thread {threads} -h {output.qual}
        """