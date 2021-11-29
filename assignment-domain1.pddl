;Header and description

(define (domain assignment1)

    ;remove requirements that are not needed
    ; (:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)
    (:requirements :adl)

    (:types
        robot
        person
        crate
        location
        content
    )

    (:predicates
        (at-robot ?r - robot ?l - location)
        (at-person ?p - person ?l - location)
        (at-crate ?c - crate ?l - location)
        (contain ?c - crate ?co - content) ; assume contains only one content
        (available ?c)
        (need ?p - person ?co - content) ; no need content already had
        (have ?p - person ?co - content)
        (load ?r - robot ?c - crate)
        (empty ?r - robot)
    )

    (:action pick-up
        :parameters (?r - robot ?c - crate ?l - location)
        :precondition (and (at-robot ?r ?l) (at-crate ?c ?l) (empty ?r) (available ?c))
        :effect (and (load ?r ?c) (not (empty ?r)))
    )
    
    (:action move-crate
        :parameters (?r - robot ?c - crate ?l1 ?l2 - location)
        :precondition (and (at-robot ?r ?l1) (at-crate ?c ?l1) (load ?r ?c))
        :effect (and (at-robot ?r ?l2) (at-crate ?c ?l2) 
                    (not (at-robot ?r ?l1)) (not (at-crate ?c ?l1)))
    )
    
    (:action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :precondition (and (at-robot ?r ?l1))
        :effect (and (at-robot ?r ?l2) (not (at-robot ?r ?l1)))
    )

    (:action deliver
        :parameters (?r - robot ?c - crate ?p - person ?l - location ?co - content)
        :precondition (and (at-robot ?r ?l) (at-crate ?c ?l) (at-person ?p ?l) 
                        (load ?r ?c) (contain ?c ?co) (need ?p ?co))
        :effect (and (not (need ?p ?co)) (have ?p ?co) 
                    (not (load ?r ?c)) (empty ?r) (not (available ?c)))
    )   

)