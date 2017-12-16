;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lengthmetrics) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; CONSTANTS
(define cm-per-inch 2.54)
(define inches-per-foot 12)
(define feet-per-yard 3)
(define yards-per-rod (+ 5 1/2))
(define rods-per-furlong 40)
(define furlongs-per-mile 8)

;; inches-> cm : number -> number
;; to determine the number of cm in some number of inches
(define (inches->cm inches)
  (* inches cm-per-inch))

;; feet->inches : number -> number
;; to determine the number of inches in some number of feet
(define (feet->inches feet)
  (* feet inches-per-foot))

;; yards->feet : number -> number
;; to determine the number of feet in some number of yards
(define (yards->feet yards)
  (* yards feet-per-yard))

;; rods->yards : number -> number
;; to determine the number of yards in some number of rods
(define (rods->yards rods)
  (* rods yards-per-rod))

;; furlongs->rods : number -> number
;; to determine the number of rods in some number of
;; furlongs
(define (furlongs->rods furlongs)
  (* furlongs rods-per-furlong))

;; miles->furlongs : number -> number
;; to determine the number of furlongs in some number of
;; miles
(define (miles->furlongs miles)
  (* miles furlongs-per-mile))

;; feet->cm : number -> number
;; to determine the number of cm in some number of feet
(define (feet->cm feet)
  (inches->cm (feet->inches feet)))

;; yards->cm : number -> number
;; to determine the number of cm in some number of yards
(define (yards->cm yards)
  (feet->cm (yards->feet yards)))

;; rods->inches : number -> number
;; to determine the number of inches in some number of rods
(define (rods->inches rods)
  (feet->inches (yards->feet (rods->yards rods))))

;; miles->feet : number -> number
;; to determine the number of feet in some number of miles
(define (miles->feet miles)
  (yards->feet 
   (rods->yards
    (furlongs->rods
     (miles->furlongs 
      miles)))))

;; EXAMPLES AS TESTS

(inches->cm 1) "should be" 2.54
(inches->cm 3) "should be" 7.62

(feet->inches 1) "should be" 12
(feet->inches 3/2) "should be" 18

(yards->feet 1) "should be" 3
(yards->feet 12) "should be" 36

(rods->inches 1) "should be" 198
(rods->inches 3/2) "should be" 297

(furlongs->rods 1) "should be" 40
(furlongs->rods 7) "should be" 280

(miles->furlongs 1) "should be" 8
(miles->furlongs 10) "should be" 80

(feet->cm 1) "should be" 30.48
(feet->cm 4) "should be" 121.92

(yards->cm 1) "should be" 91.44
(yards->cm 2) "should be" 182.88

(rods->inches 1) "should be" 198
(rods->inches 3.5) "should be" 693

(miles->feet 1) "should be" 5280
(miles->feet 4) "should be" 21120