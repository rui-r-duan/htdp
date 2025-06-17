;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname htdp) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; § 3 How to Design Programs

; § 3.1 Designing Functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Information and Data


; example of data definition (class):
; A Temperature is a Number.
; interpretation represents Celsius degrees

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The Design Process

; 1. Express how you wish to represent information as data.

; We use numbers to represent centimeters.

; 2. Write down a signature, a statement of purpose, and a function header.

;;; signature
; String -> Number

; Temperature -> String

; Number String Image -> Image

;;; purpose statement
; What does the function compute?

; Good programmers write two purpose statements: one for the reader who may
; have to modify the code and another one for the person who wishes to use
; the program but not read it.

;;; header (stub)
; (define (f a-string) 0) ; String -> Number
; (define (g n) "a") ; Temperature -> String
; (define (h num str img) (empty-scene 100 100)) ; Number String Image -> Image

;;; a complete example
; Number String Image -> Image
; adds s to img,
; y pixels from the top and 10 from the left
;;(define (add-image y s img)
;;  (empty-scene 100 100))

; 3. Illustrate the signature and the purpose statement with some functional
; examples.

; Number -> Number
; computes the area of a square with side len
; given: 2, expect: 4
; given: 7, expect: 49
;(define (area-of-square len) 0)

; 4. Take inventory to understand what are the givens and what we need to
; compute.

; For simple functions, we know that they are given data via parameters.
; To remind ourselves of this fact, we replace the function's body with
; a template.

; (define (area-of-square len)
;    (... len ...))

; 5. Code.
; Number -> Number
; computes the area of a square with side len
; given: 2, expect: 4
; given: 7, expect: 49
(define (area-of-square len)
  (sqr len))

; Number String Image -> Image
; adds s to img, y pixels from top, 10 pixels to the left
; given: 
;    5 for y, 
;    "hello" for s, and
;    (empty-scene 100 100) for img
; expected: 
;    (place-image (text "hello" 10 "red") 10 5 ...)
;    where ... is (empty-scene 100 100)
(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))

; 6. Test the function on the examples that you worked out before.

;;; Exercise 34
; String -> 1String
; extracts the first character from a non-empty string.
; Don't worry about empty strings.
; given: "a", expected: "a"
; given: "ba", expected: "b"
; given: "壹贰", expected: "壹"
(define (string-first s)
  (substring s 0 1))

;;; Exercise 35
; String -> 1String
; extracts the last character from a non-empty string.
; given: "a", expected: "a"
; given: "ab", expected: "b"
; given: "壹贰", expected: "贰"
(define (string-last s)
  (substring s (- (string-length s) 1)))

;;; Exercise 36
; Image -> Number
; counts the number of pixels in a given image.
; given: (rectangle 10 50 "outline" "green"), expected: 10x50=500
; given: (circle 20 "solid" "red"), expected: width x height
(define (image-area img)
  (* (image-width img) (image-height img)))

;;; Exercise 37
; String -> String
; produces a string like the given one with the first character removed.
; Empty string is a valid input.
; given: "", expected: ""
; given: "a", expected: ""
; given: "壹贰", expected: "贰"
(define (string-rest s)
  (if (= (string-length s) 0)
      ""
      (substring s 1)))

;;; Exercise 38
; produces a string like the given one with the last character removed.
; Empty string is a valid input.
; given: "", expected: ""
; given: "a", expected: ""
; given: "ab", expected: "a"
; given: "壹贰", expected: "壹"
(define (string-remove-last s)
  (if (= (string-length s) 0)
      ""
      (substring s 0 (- (string-length s) 1))))

; § 3.4 From Functions to Programs
; We recommend keeping around a list of needed functions or a wish list.
; Each entry on a wish list should consist of three things:
; - a meaningful name for the function
; - a signature
; - a purpose statement
;
; For the design of a batch program,
; - main function
;
; For the design of an interactive program
; - event handlers
; - stop-when function
; - scene rendering function
;
; When the list is empty, you are done.

; § 3.5 On Testing
; Number -> Number
; converts Fahrenheit temperatures to Celsius temperatures 
 
(check-expect (f2c -40) -40)
(check-expect (f2c 32) 0)
(check-expect (f2c 212) 100)
 
(define (f2c f)
  (* 5/9 (- f 32)))

;(check-expect (render 50)
;              (place-image CAR 50 Y-CAR BACKGROUND))
;
;(check-expect (render 200)
;              (place-image CAR 200 Y-CAR BACKGROUND))
