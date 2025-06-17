;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname programs) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
(define (C f)
  (* 5/9 (- f 32)))

(define (convert in out)
  (write-file
   out
   (string-append
    (number->string (C
                     (string->number (read-file in))))
    "\n")))

(write-file "sample.dat" "212")
(convert "sample.dat" 'stdout)

; Exercise 31
(define (letter first-name last-name signature-name)
  (string-append
   (opening first-name)
   "\n\n"
   (body first-name last-name)
   "\n\n"
   (closing signature-name)))
 
(define (opening first-name)
  (string-append "Dear " first-name ","))
 
(define (body first-name last-name)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " last-name " have won our lottery. So, " "\n"
   first-name ", " "hurry and pick up your prize."))
 
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

; Exercise 32
; 0. a phone call
; 1. a touch on screen, a finger move on screen
; 2. an car defect signal
; 3. an object image is detected in the intelligent glasses
; 4. clothes temperature drops below the threshold
; 5. skiing speed exceeds the threshold
; 6. heart beat too fast
; 7. a voice/text/image command to Generative AI
; 8. a mouse clicking
; 9. an event message received from Kafka

(define (number->square s)
  (square s "solid" "red"))

(big-bang 100 [to-draw number->square])

(big-bang 100
  [to-draw number->square]
  [on-tick sub1]
  [stop-when zero?])

(define (reset s ke)
  100)

(big-bang 100
  [to-draw number->square]
  [on-tick sub1]
  [stop-when zero?]
  [on-key reset])

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

(define (main y)
  (big-bang y
    [on-tick sub1]
    [stop-when zero?]
    [to-draw place-dot-at]
    [on-key stop]))

(define (place-dot-at y)
  (place-image DOT 50 y BACKGROUND))

(define (stop y ke)
  0)