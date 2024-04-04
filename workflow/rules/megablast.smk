rule megablast:
# works
    input:
       contigs='../results/megahit/{sample}.contigs.fa',
       check='../results/check/{sample}.mh.done.txt'
    output:
        tsv='../results/megablast/{sample}_ntviruses.tsv',
    conda: 
        "../envs/blast.yml"
    threads: 6
    shell:
        """
        blastn -query {input.contigs} \
        -db /group/datalabgrp/ctbrown/chunting/viral_blast_db/nt_viruses \
        -num_threads {threads} -evalue 0.001 \
        -max_target_seqs 1 -outfmt "6 qseqid qlen sseqid sacc length pident evalue sskingdom ssciname staxid" \
        -task megablast -out {output.tsv}
        """