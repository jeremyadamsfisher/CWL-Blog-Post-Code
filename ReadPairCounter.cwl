class: CommandLineTool
cwlVersion: v1.0
requirements:
- class: InlineJavascriptRequirement
hints:
  DockerRequirement:
    dockerPull: readpaircounter
baseCommand:
- count_reads.py
inputs:
  PairedReads:
    inputBinding:
      position: 0
    type:
      type: record
      fields:
        - name: r1
          type: File
          inputBinding:
            prefix: --R1
            position: 1
        - name: r2
          type: File
          inputBinding:
            prefix: --R2
            position: 2
outputs:
  ReadCount:
    type: int
    outputBinding:
      loadContents: true
      glob: output.json
      outputEval: $( JSON.parse(self[0].contents).record_count )
