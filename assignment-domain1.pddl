; Domain file for the Problem 1 of APTP Assignment

(define (domain assignment1)

    (:requirements :strips :typing)

    (:types
        robot ; robotic agent
        person
        crate
        location
        content ; content of creates: food, medicine, ...
    )

    ; TODO: at-x can be modeled as a single predicate 'at'

    (:predicates
        (robot_at ?r - robot ?l - location)     ;robot r is at location l
        (person_at ?p - person ?l - location)   ;person p is at location l
        (crate_at ?c - crate ?l - location)     ;crate c is at location l
        (contain ?c - crate ?co - content)      ;crate c has content co (TODO: assume contains only one content)
        (available ?c - crate)                  ;crate c has not been delivered yet
        (need ?p - person ?co - content)        ;person p needs content co (TODO: no need content already had)
        (have ?p - person ?co - content)        ;person p has content co (TODO: can need co even if it has co?)
        (hold ?r - robot ?c - crate)            ;robot r holds crate c
        (empty ?r - robot)                      ;robot r is empty
    )

    ; robot r picks up the crate c at location l
    (:action pick_up
        :parameters (?r - robot ?c - crate ?l - location)
        :precondition (and (robot_at ?r ?l) (crate_at ?c ?l) (empty ?r) (available ?c))
        :effect (and (hold ?r ?c) (not (empty ?r)) (not (crate_at ?c ?l)))
    )
    
    ; robot r moves from location l1 to location l2
    (:action move
        :parameters (?r - robot ?l1 ?l2 - location)
        :precondition (and (robot_at ?r ?l1))
        :effect (and (robot_at ?r ?l2) (not (robot_at ?r ?l1)))
    )

    ; robot r delivers crate c with content co to person p at location l
    (:action deliver
        :parameters (?r - robot ?c - crate ?p - person ?l - location ?co - content)
        :precondition (and (robot_at ?r ?l) (person_at ?p ?l) 
                        (hold ?r ?c) (contain ?c ?co) (need ?p ?co))
        :effect (and (not (need ?p ?co)) (have ?p ?co) (crate_at ?c ?l)
                    (not (hold ?r ?c)) (empty ?r) (not (available ?c)))
    )   

)