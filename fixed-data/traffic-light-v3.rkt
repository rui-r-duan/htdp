;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light-v3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 4.7 Finite State Worlds

; Exercise 61: use constants to represent the numbers which denotes the light
; state.

; data definition

(define RED 0)
(define GREEN 1)
(define YELLOW 2)

; An S-TrafficLight is one of:
; – RED
; – GREEN
; – YELLOW

; a signature, a purpose statement, and a stub

; S-TrafficLight -> S-TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next-symbolic RED) GREEN)
(check-expect (tl-next-symbolic GREEN) YELLOW)
(check-expect (tl-next-symbolic YELLOW) RED)
(define (tl-next-numeric cs)
  (modulo (+ cs 1) 3))
(define (tl-next-symbolic cs)
  (cond
    [(equal? cs RED) GREEN]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]))

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

(define RED-STATE-IMG
  (place-image (light "red" "on")
               POS-X-RED POS-Y
               (place-image (light "yellow" "off")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "off")
                                         POS-X-GRN POS-Y
                                         MTSCN))))
(define YELLOW-STATE-IMG
  (place-image (light "red" "off")
               POS-X-RED POS-Y
               (place-image (light "yellow" "on")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "off")
                                         POS-X-GRN POS-Y
                                         MTSCN))))
(define GREEN-STATE-IMG
  (place-image (light "red" "off")
               POS-X-RED POS-Y
               (place-image (light "yellow" "off")
                            POS-X-YLW POS-Y
                            (place-image (light "green" "on")
                                         POS-X-GRN POS-Y
                                         MTSCN))))

; S-TrafficLight -> Image
; renders the current state cs as an image
(check-expect (tl-render RED) RED-STATE-IMG)
(check-expect (tl-render GREEN) GREEN-STATE-IMG)
(check-expect (tl-render YELLOW) YELLOW-STATE-IMG)
(define (tl-render cs)
  (cond
    [(equal? cs RED) RED-STATE-IMG]
    [(equal? cs YELLOW) YELLOW-STATE-IMG]
    [(equal? cs GREEN) GREEN-STATE-IMG]))

; S-TrafficLight -> S-TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-symbolic 1]))

