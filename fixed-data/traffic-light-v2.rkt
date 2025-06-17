;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.7 Finite State Worlds

; Exercise 60: use numbers instead of string to denote the traffic light state

; data definition

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

; a signature, a purpose statement, and a stub

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next 0) 1)
(check-expect (tl-next 1) 2)
(check-expect (tl-next 2) 0)
(define (tl-next cs)
  (modulo (+ cs 1) 3))

(define CELL-SIZE 30)
(define SCN-WIDTH (* CELL-SIZE 3))
(define SCN-HEIGHT CELL-SIZE)
(define RADIUS 10)

(define POS-Y (/ CELL-SIZE 2))
(define POS-X-RED (/ CELL-SIZE 2))
(define POS-X-YLW (+ POS-X-RED CELL-SIZE))
(define POS-X-GRN (+ POS-X-YLW CELL-SIZE))

(define MTSCN (empty-scene SCN-WIDTH SCN-HEIGHT))

; Color String, (or/c "on" "off") -> Image
; Draw a light according to the name `type` and on or off state.
(define (light type on/off)
  (circle RADIUS
          (cond
            [(string=? "on" on/off) "solid"]
            [(string=? "off" on/off) "outline"])
          type))

(define RED
  (place-image (light "red" "on")
               POS-X-RED POS-Y
               (place-image (light "yellow" "off")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "off")
                                         POS-X-GRN POS-Y
                                         MTSCN))))
(define YELLOW
  (place-image (light "red" "off")
               POS-X-RED POS-Y
               (place-image (light "yellow" "on")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "off")
                                         POS-X-GRN POS-Y
                                         MTSCN))))
(define GREEN
  (place-image (light "red" "off")
               POS-X-RED POS-Y
               (place-image (light "yellow" "off")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "on")
                                         POS-X-GRN POS-Y
                                         MTSCN))))

; N-TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render 0) RED)
(check-expect (tl-render 2) YELLOW)
(check-expect (tl-render 1) GREEN)
(define (tl-render cs)
  (cond
    [(= 0 cs) RED]
    [(= 2 cs) YELLOW]
    [(= 1 cs) GREEN]))

; N-TrafficLight -> N-TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

