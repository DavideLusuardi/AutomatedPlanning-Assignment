;Header and description
;execution: enhsp-2020 --domain assignment-domain2.pddl --problem assignment-problem2.pddl

(define (domain assignment2)

    (:requirements :strips :typing :numeric-fluents)

    (:types
        robot
        person
        crate
        location
        content
        carrier
    )

    (:predicates
        (at-robot ?r - robot ?l - location)
        (at-person ?p - person ?l - location)
        (at-crate ?c - crate ?l - location)
        (at-carrier ?ca - carrier ?l - location)
        (contain ?c - crate ?co - content) ; assume contains only one content
        (available ?c - crate)
        (need ?p - person ?co - content) ; no need content already had
        (have ?p - person ?co - content)
        (load ?ca - carrier ?c - crate)
    )


    (:functions
        ; (full-capacity) - number
        (capacity ?ca - carrier) - number
        (cost) - number
    )

    (:action pick-up
        :parameters (?r - robot ?ca - carrier ?c - crate ?l - location)
        :precondition (and (at-robot ?r ?l) (at-carrier ?ca ?l) (at-crate ?c ?l) 
                            (available ?c) (> (capacity ?ca) 0))
        :effect (and (load ?ca ?c) (decrease (capacity ?ca) 1) (not (at-crate ?c ?l)) (increase (cost) 1))
    )
    
    (:action move-carrier
        :parameters (?r - robot ?ca - carrier ?l1 ?l2 - location)
        :precondition (and (at-robot ?r ?l1) (at-carrier ?ca ?l1))
        :effect (and (at-robot ?r ?l2) (at-carrier ?ca ?l2) 
                    (not (at-robot ?r ?l1)) (not (at-carrier ?ca ?l1)) (increase (cost) 1))
    )
    
    (:action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :precondition (and (at-robot ?r ?l1))
        :effect (and (at-robot ?r ?l2) (not (at-robot ?r ?l1)) (increase (cost) 1))
    )

    (:action deliver
        :parameters (?r - robot ?ca - carrier ?c - crate ?p - person ?l - location ?co - content)
        :precondition (and (at-robot ?r ?l) (at-carrier ?ca ?l) (at-person ?p ?l) 
                        (load ?ca ?c) (contain ?c ?co) (need ?p ?co))
        :effect (and (not (need ?p ?co)) (have ?p ?co) (at-crate ?c ?l) 
                    (not (load ?ca ?c)) (increase (capacity ?ca) 1) (not (available ?c)) (increase (cost) 1))
    )

)