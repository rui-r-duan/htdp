;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname arith-str) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
"坏人"
(string-append "what a " "lovely " "day" " 4 BSL")

; Exercise 2
(define prefix "hello")
(define suffix "world")
(string-append prefix "_" suffix)

(substring "hello world" 1 5)
(substring "hello world" 4)

;(string-length 42)
(+ (string-length "hello world") 20)
(+ (string-length (number->string 42)) 2)

; Exercise 3
(define str "helloworld")
(define ind "0123456789")
(define i 5)
(string-append (substring str 0 i) "_" (substring str i))

; Exercise 4
(define (del-char-at i str)
  (string-append (substring str 0 i) (substring str (+ i 1))))
(del-char-at i str)
; invalid index
;(del-char-at 10 str)
;(del-char-at -1 str)