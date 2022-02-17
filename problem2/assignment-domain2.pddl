; Domain file for the Problem 2 of APTP Assignment

(define (domain assignment2)

    (:requirements :strips :typing :fluents)

    (:types
        robot ; robotic agent
        person
        crate
        location
        content ; content of creates: food, medicine, ...
        carrier
    )

    (:predicates
        (robot_at ?r - robot ?l - location)         ;robot r is at location l
        (person_at ?p - person ?l - location)       ;person p is at location l
        (crate_at ?c - crate ?l - location)         ;crate c is at location l
        (carrier_at ?ca - carrier ?l - location)    ;carrier ca is at location l
        (contain ?c - crate ?co - content)          ;crate c has content co
        (available ?c - crate)                      ;crate c has not been delivered yet
        (need ?p - person ?co - content)            ;person p needs content co
        (have ?p - person ?co - content)            ;person p has content co
        (load ?ca - carrier ?c - crate)             ;carrier ca loads crate c
    )


    (:functions
        (capacity ?ca - carrier) - number ; carrier ca remaining capacity
    )

    ; robot r picks up and puts crate c at location l into carrier ca
    ; capacity of carrier ca will be decreased by 1
    (:action pick_up
        :parameters (?r - robot ?ca - carrier ?c - crate ?l - location)
        :precondition (and (robot_at ?r ?l) (carrier_at ?ca ?l) (crate_at ?c ?l) 
                            (available ?c) (> (capacity ?ca) 0))
        :effect (and (load ?ca ?c) (decrease (capacity ?ca) 1) (not (crate_at ?c ?l)))
    )
    
    ; robot r moves carrier ca from location l1 to location l2
    (:action move_carrier
        :parameters (?r - robot ?ca - carrier ?l1 ?l2 - location)
        :precondition (and (robot_at ?r ?l1) (carrier_at ?ca ?l1))
        :effect (and (robot_at ?r ?l2) (carrier_at ?ca ?l2) 
                    (not (robot_at ?r ?l1)) (not (carrier_at ?ca ?l1)))
    )
    
    ; robot r moves from location l1 to location l2
    (:action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :precondition (and (robot_at ?r ?l1))
        :effect (and (robot_at ?r ?l2) (not (robot_at ?r ?l1)))
    )

    ; robot r delivers crate c with content co, situated in carrier ca, to person p at location l
    (:action deliver
        :parameters (?r - robot ?ca - carrier ?c - crate ?p - person ?l - location ?co - content)
        :precondition (and (robot_at ?r ?l) (carrier_at ?ca ?l) (person_at ?p ?l) 
                        (load ?ca ?c) (contain ?c ?co) (need ?p ?co))
        :effect (and (not (need ?p ?co)) (have ?p ?co) (crate_at ?c ?l) 
                    (not (load ?ca ?c)) (increase (capacity ?ca) 1) (not (available ?c)))
    )

)