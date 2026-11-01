; ==============================================================================
; BM311 Computer Architecture - Assembly Homework 2
; Problem: In-place Selection Sort of 1000 16-bit integers (addresses 1000 - 1999)
; Architecture: 16-bit Memory, 2-operand Instruction Set Architecture (ISA)
; ==============================================================================
; Register Mapping:
;   R1: Outer Loop Pointer (Current partition index i: 1000 -> 1998)
;   R2: Inner Loop Pointer (Scan index j: R1+1 -> 1999)
;   R3: Pointer to Minimum Element found so far (min_idx)
;   R4: Scratchpad / Comparison & Arithmetic Register
; ==============================================================================

; --- Initialization ---
100: LDA R1, 1000           ; Load base address (1000) into R1

; --- Outer Loop Start ---
101: LDA R3, R1             ; Initialize min address pointer R3 with current outer pointer R1
102: LDA R2, R1             ; Initialize inner scan pointer R2 with R1
103: ADD R2, 1              ; R2 = R2 + 1 (start inner scan from R1 + 1)

; --- Inner Loop Start ---
104: LDA R4, R2             ; Load address/value from R2 into R4
105: SUB R4, R3             ; R4 = R4 - R3 (compare current candidate with current min)
106: JN 108                 ; If result < 0 (candidate < min), jump to 108 to update min
107: JMP 109                ; Else, skip update and jump to boundary check at 109
108: LDA R3, R2             ; Update min pointer: R3 = R2

; --- Inner Loop Boundary Check ---
109: LDA R4, 1999           ; Load upper limit of array (1999) into R4
110: SUB R4, R2             ; R4 = R4 - R2 (check if R2 has reached 1999)
111: JZ 114                 ; If R4 == 0 (end of inner loop), jump to SWAP at 114
112: ADD R2, 1              ; Increment inner scan pointer R2
113: JMP 104                ; Loop back to start of inner loop

; --- SWAP Routine ---
114: LDA R4, R1             ; Preserve original R1 value/data into scratchpad R4
115: MOV R1, R3             ; Copy minimum value/pointer R3 into R1
116: STA R3, R4             ; Store preserved original value from R4 into address/register R3

; --- Outer Loop Boundary Check ---
117: LDA R4, 1998           ; Load outer loop upper limit (1998) into R4
118: SUB R4, R1             ; R4 = R4 - R1 (check if outer loop reached n-1)
119: JZ 122                 ; If R4 == 0, sorting completed! Jump to End at 122
120: ADD R1, 1              ; Increment outer pointer R1 for next pass
121: JMP 101                ; Jump unconditionally to start of outer loop

; --- End of Program ---
122: ; HALT / Program End
