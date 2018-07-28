class: Workflow
cwlVersion: v1.0
requirements:
  - class: ScatterFeatureRequirement
inputs:
  fastqs: File[]
outputs:
  ReadCount:
    type: Any
    outputSource: ReadPairCounter/ReadCount
steps:
  Grouper:
    run: ./ReadPairGrouper.cwl
    in:
      fastqs: fastqs
    out:
      - PairedReads
  ReadPairCounter:
    run: ./ReadPairCounter.cwl
    in:
      PairedReads: Grouper/PairedReads
    out:
      - ReadCount
    scatter:
      - PairedReads
