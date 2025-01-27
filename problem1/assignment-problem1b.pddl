; Problem file for the Problem 1 of APTP Assignment

(define (problem problem1b) (:domain assignment1)
    (:objects 
        robot1 - robot
        p1 p2 p3 p4 p5 p6 p7 p8 - person
        c1 c2 c3 c4 c5 c6 c7 c8 - crate
        depot l1 l2 l3 l4 - location
        medicine food beverage - content
    )

    ; a single robotic agent is located at the depot
    ; all crates are located at the depot
    (:init
        (robot_at robot1 depot) 
        (person_at p1 l1) (person_at p2 l2) (person_at p3 l3) (person_at p4 l3) 
        (person_at p5 l4) (person_at p6 l4) (person_at p7 l4) (person_at p8 l4)
        (crate_at c1 depot) (crate_at c2 depot) (crate_at c3 depot) (crate_at c4 depot) 
        (crate_at c5 depot) (crate_at c6 depot) (crate_at c7 depot) (crate_at c8 depot)
        (contain c1 medicine) (contain c2 food) (contain c3 beverage) (contain c4 medicine) 
        (contain c5 food) (contain c6 beverage) (contain c7 medicine) (contain c8 food)
        (available c1) (available c2) (available c3) (available c4) 
        (available c5) (available c6) (available c7) (available c8)
        (need p1 food) (need p1 beverage)
        (need p3 medicine)
        (need p4 food)
        (need p5 food) (need p5 medicine) (need p5 beverage)
        (have p1 medicine) (have p2 food) (have p3 beverage)
        (empty robot1)
    )

    ; people have crates containing what they need
    (:goal (and
        (have p1 food) (have p1 beverage)
        (have p3 medicine)
        (have p4 food)
        (have p5 food) (have p5 medicine) (have p5 beverage)
    ))

)
