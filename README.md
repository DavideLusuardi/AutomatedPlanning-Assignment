# Assignment of Automated Planning: Theory and Practice

## problems
* 

## run
problem 1:
$ lama assignment-domain1.pddl assignment-problem1.pddl

problem 2:
$ enhsp-2020 --domain assignment-domain2.pddl --problem assignment-problem2.pddl

problem 3:
$ planutils run optic "-N assignment-domain3.pddl assignment-problem3.pddl"
$ planutils run optic "assignment-domain3.pddl assignment-problem3a.pddl"
$ planutils run tfd "assignment-domain3.pddl assignment-problem3.pddl"


## TODO
* Crate contents shall be modeled in a generic way, so that new contents can easily be introduced in the problem instance.
* Each person either has or does not have a crate with a specific content.
* assume people need just one crate with needed content
* crates at the same location of people who need their contents cannot directly be delivered to people
* people who already have crates with content co but need content co 