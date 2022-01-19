;Header and description

(define (domain assignment1)

    (:requirements :strips :typing)

    (:types
        robot
        person
        crate
        location
        content
    )

    ; TODO: at-x can be modeled as a single predicate 'at'

    (:predicates
        (at-robot ?r - robot ?l - location)     ;robot r is at location l
        (at-person ?p - person ?l - location)   ;person p is at location l
        (at-crate ?c - crate ?l - location)     ;crate c is at location l
        (contain ?c - crate ?co - content)      ;crate c have content co (TODO: assume contains only one content)
        (available ?c - crate)                  ;crate c has not been delivered yet
        (need ?p - person ?co - content)        ;person p needs content co (TODO: no need content already had)
        (have ?p - person ?co - content)        ;person p has content co (TODO: can need co even if it has co?)
        (load ?r - robot ?c - crate)            ;robot r loads crate c
        (empty ?r - robot)                      ;robot r is empty
    )

    (:action pick-up
        :parameters (?r - robot ?c - crate ?l - location)
        :precondition (and (at-robot ?r ?l) (at-crate ?c ?l) (empty ?r) (available ?c))
        :effect (and (load ?r ?c) (not (empty ?r)) (not (at-crate ?c ?l)))
    )
    
    ; (:action move-crate
    ;     :parameters (?r - robot ?c - crate ?l1 ?l2 - location)
    ;     :precondition (and (at-robot ?r ?l1) (load ?r ?c))
    ;     :effect (and (at-robot ?r ?l2) (not (at-robot ?r ?l1)))
    ; )
    
    (:action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :precondition (and (at-robot ?r ?l1))
        :effect (and (at-robot ?r ?l2) (not (at-robot ?r ?l1)))
    )

    (:action deliver
        :parameters (?r - robot ?c - crate ?p - person ?l - location ?co - content)
        :precondition (and (at-robot ?r ?l) (at-person ?p ?l) 
                        (load ?r ?c) (contain ?c ?co) (need ?p ?co))
        :effect (and (not (need ?p ?co)) (have ?p ?co) (at-crate ?c ?l)
                    (not (load ?r ?c)) (empty ?r) (not (available ?c)))
    )   

)