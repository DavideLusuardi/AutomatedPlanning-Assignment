
set instance robot1 robot
set instance carrier1 carrier
set instance p1 person
set instance p2 person
set instance c1 crate
set instance c2 crate
set instance depot location
set instance l1 location
set instance medicine content
set instance food content



set predicate (at_robot robot1 depot)
        
set predicate (at_carrier carrier1 depot)
        
set predicate (at_person p1 l1) 
set predicate (at_person p2 l1)
        
set predicate (at_crate c1 depot) 
set predicate (at_crate c2 depot) 
        
set predicate (contain c1 medicine) 
set predicate (contain c2 food) 
        
set predicate (available c1) 
set predicate (available c2) 
        
set predicate (need p1 medicine)
set predicate (need p2 food)
        
set predicate (free robot1)

set function (= (capacity carrier1) 4)


set goal (and (have p1 medicine) (have p2 food))
