# 4-to-2 Encoder (coding drill)

Plain (non-priority) encoder, assumes only one input active at a time. Self-added a `valid`
output to resolve the ambiguity between "no input active" and "i0 active" (both would otherwise
produce a=0,b=0) — same signal purpose as in the earlier priority encoder project.
