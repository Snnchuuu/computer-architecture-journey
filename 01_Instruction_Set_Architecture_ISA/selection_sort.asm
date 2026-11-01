; ==============================================================================
; Student Name-Surname: Sinan Gün
; Student No: 25118080047
; Lecture: BM-311 Bilgisayar Mimarisi
; Homework: In-place Selection Sort of 1000 16-bit integers (addresses 1000 - 1999)
; Architecture: 16-bit Memory, 2-operand Instruction Set Architecture (ISA)
; ==============================================================================
; Register Mapping:
;   R1: Outer Loop Pointer (Current partition index i: 1000 -> 1998)
;   R2: Inner Loop Pointer (Scan index j: R1+1 -> 1999)
;   R3: Pointer to Minimum Element found so far (min_idx)
;   R4: Scratchpad / Comparison & Arithmetic Register
; Note on Addressing:
;   Rx   -> Direct Register value / Pointer address
;   [Rx] -> Indirect Memory Dereference (Value stored at memory address Rx)
; ==============================================================================

; --- Başlangıç ---
100: LDA R1, 1000           ; R1 registerine dizinin başlangıç adresi olan 1000’i yaz

; --- Dış Döngü Başlangıcı ---
101: LDA R3, R1             ; R3 register'ına (minimum değerin adresi) R1'deki adresi yükle.
102: LDA R2, R1             ; R2 register'ına (iç döngü indeks adresi) R1'deki adresi yükle.
103: ADD R2, 1              ; R2 registerindaki adresi 1 artır. (Yani taramaya R1 + 1 adresinden başla.)

; --- İç Döngü Başlangıcı ---
104: LDA R4, [R2]           ; R2 adresinin içindeki veriyi (sayıyı) R4 registerına yükle.
105: SUB R4, [R3]           ; R4'teki veriden, R3 adresinin içindeki (minimum) veriyi çıkar.
106: JN 108                 ; Sonuç negatif ise 108. adrese zıplar (yeni min bulundu).
107: JMP 109                ; Sonuç negatif değil ise 108’i atlar ve 109’a geçer.
108: LDA R3, R2             ; Yeni minimum verinin adresini (R2) R3 registerına kaydet.

; --- İç Döngü Sınır Kontrolü ---
109: LDA R4, 1999           ; R4'e kontrol için dizinin son adresini (1999) yükle
110: SUB R4, R2             ; R4’teki veriden R2’deki veriyi çıkarır ve R4’e yazar.
111: JZ 114                 ; Sonuç sıfır ise iç döngüyü bitirerek 114. adrese zıplar.
112: ADD R2, 1              ; R2’deki veriye 1 ekler ve R2’ye yazar.
113: JMP 104                ; İç döngünün başına şartsız geri döner.

; --- SWAP İşlemi Bölümü ---
114: LDA R4, [R1]           ; R1 adresindeki veriyi kaybolmaması için R4 registerına yedekle.
115: MOV [R1], [R3]         ; R3 adresindeki en küçük veriyi R1 adresine kopyala.
116: STA [R3], R4           ; R4'e yedeklenen eski veriyi R3 adresine (hafızaya) aktar.

; --- Dış Döngü Sınır Kontrolü ---
117: LDA R4, 1998           ; R4'e kontrol için dış döngünün son adresini (1998) yükle
118: SUB R4, R1             ; R4 adresinden R1’de bulunan mevcut döngü adresini çıkar.
119: JZ 122                 ; Sonuç sıfır ise sıralama bitmiştir programın sonuna zıplar.
120: ADD R1, 1              ; Sıralama bitmediyse işlemin devamı için R1’deki adrese 1 ekle.
121: JMP 101                ; Dış döngünün en başına şartsız zıplar.

; --- Program Sonu ---
122: ; Program Sonu
