; Domain file for the Problem 3 of APTP Assignment

(define (domain assignment3)

    (:requirements :strips :typing :fluents :negative-preconditions :durative-actions)

    (:types
        robot ; robotic agent
        person
        crate
        location
        content ; content of creates: food, medicine, ...
        carrier
    )

    (:predicates
        (robot_at ?r - robot ?l - location) ;robot r is at location l
        (person_at ?p - person ?l - location) ;person p is at location l
        (crate_at ?c - crate ?l - location) ;crate c is at location l
        (carrier_at ?ca - carrier ?l - location) ;carrier ca is at location l
        (contain ?c - crate ?co - content) ;crate c has content co
        (available ?c - crate) ;crate c has not been delivered yet
        (busy ?r - robot) ; TODO
        (need ?p - person ?co - content) ;person p needs content co
        (have ?p - person ?co - content) ;person p has content co
        (load ?ca - carrier ?c - crate) ;carrier ca loads crate c
    )


    (:functions
        (capacity ?ca - carrier) - number ; carrier ca remaining capacity
        ; (cost) - number ; TODO
    )

    ; robot r picks up and puts crate c at location l into carrier ca
    ; capacity of carrier ca will be decreased by 1
    (:durative-action pick_up
        :parameters (?r - robot ?ca - carrier ?c - crate ?l - location)
        :duration (= ?duration 2)
        :condition (and (over all (robot_at ?r ?l)) (over all (carrier_at ?ca ?l)) (at start (crate_at ?c ?l))
                            (at start (not (busy ?r))) (over all (available ?c)) (at start (> (capacity ?ca) 0)))
        :effect (and (at start (busy ?r)) (at end (not (busy ?r))) (at end (load ?ca ?c)) 
                (at start (decrease (capacity ?ca) 1)) (at start (not (crate_at ?c ?l))))
    )
    
    ; robot r moves carrier ca from location l1 to location l2
    (:durative-action move_carrier
        :parameters (?r - robot ?ca - carrier ?l1 ?l2 - location)
        :duration (= ?duration 4)
        :condition (and (at start (robot_at ?r ?l1)) (at start (carrier_at ?ca ?l1)))
        :effect (and (at end (robot_at ?r ?l2)) (at end (carrier_at ?ca ?l2))
                    (at start (not (robot_at ?r ?l1))) (at start (not (carrier_at ?ca ?l1))))
    )
    
    ; robot r moves from location l1 to location l2
    (:durative-action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :duration (= ?duration 3)
        :condition (and (at start (robot_at ?r ?l1)))
        :effect (and (at end (robot_at ?r ?l2)) (at start (not (robot_at ?r ?l1))))
    )

    ; robot r delivers crate c with content co, situated in carrier ca, to person p at location l
    (:durative-action deliver
        :parameters (?r - robot ?ca - carrier ?c - crate ?p - person ?l - location ?co - content)
        :duration (= ?duration 1)
        :condition (and (over all (robot_at ?r ?l)) (over all (carrier_at ?ca ?l)) (over all (person_at ?p ?l))
                        (at start (not (busy ?r))) (at start (load ?ca ?c)) (over all (contain ?c ?co)) 
                        (at start (need ?p ?co)))
        :effect (and (at start (busy ?r)) (at end (not (busy ?r))) (at start (not (load ?ca ?c))) 
                (at start (not (need ?p ?co))) (at end (have ?p ?co)) (at end (not (available ?c))) 
                (at end (crate_at ?c ?l)) (at end (increase (capacity ?ca) 1)))
    )

    ; TODO: assume each robot can perform just one action per time -> many robot can perform the same action in parallel

)