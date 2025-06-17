;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname interactive-prog) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

(main 90)

