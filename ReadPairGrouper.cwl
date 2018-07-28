class: ExpressionTool
requirements:
- class: InlineJavascriptRequirement
cwlVersion: v1.0
inputs:
  fastqs:
    type: File[]
outputs:
  PairedReads:
    type:
      type: array
      items:
        type: record
        fields:
        - name: r1
          type: File
        - name: r2
          type: File
expression: |
  ${
      //group by sample name
      var samples = {};
      for (var i = 0; i < inputs.fastqs.length; i++) {
        var f = inputs.fastqs[i];
        var fp = f.path;
        if (!fp) {
          fp = f.location
        }
        var name = fp.substring(fp.lastIndexOf('/') + 1);

        var groups = name.match(/^(.+)(_R[12]_)(.+)$/);
        var samplename = groups[1];
        var R = groups[2];

        if (!samples[samplename]) {
            samples[samplename] = {r1: null, r2: null};
        }

        if (R == "_R1_") {
            samples[samplename].r1 = f;
        } else if (R == "_R2_") {
            samples[samplename].r2 = f;
        }
      }
      // pivot
      var PairedReads = Object.keys(samples).map((k)=>samples[k])
      return {PairedReads: PairedReads};
  }
