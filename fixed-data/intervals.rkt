;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname intervals) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.4 Intervals
; Sample Problem: Design a program that simulates the descent of a UFO.

; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define UFO (overlay (circle 10 "solid" "green")
                     (rectangle 36 5 "solid" "green")))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
     [on-tick nxt]
     [to-draw render/status]))

; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))
 
; WorldState -> Image
; places UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image UFO
                                       (/ (image-width MTSCN) 2)
                                       11 MTSCN))
(define (render y)
  (place-image UFO
               (/ (image-width MTSCN) 2)
               y MTSCN))

; Sample Problem: Add a status line.

; "descending": 0 <= UFO height < 1/3 of canvas height
; "closing in": 1/3 of canvas height <= UFO height < canvas height
; "landed":     UFO height >= canvas height

; WorldState -> Image
; adds a status line to the scene created by render
(check-expect (render/status 10)
              (place-image (text "descending" 11 "green")
                           20 20
                           (render 10)))
;(define (render/status y)
;  (cond
;    [(<= 0 y CLOSE)
;     (place-image (text "descending" 11 "green")
;                  10 10
;                  (render y))]
;    [(and (< CLOSE y) (<= y HEIGHT))
;     (place-image (text "closing in" 11 "orange")
;                  10 10
;                  (render y))]
;    [(> y HEIGHT)
;     (place-image (text "landed" 11 "red")
;                  10 10
;                  (render y))]))
(define (render/status y)
  (place-image
   (cond
     [(<= 0 y CLOSE)
      (text "descending" 11 "green")]
     [(and (< CLOSE y) (<= y HEIGHT))
      (text "closing in" 11 "orange")]
     [(> y HEIGHT)
      (text "landed" 11 "red")])
   20 20
   (render y)))