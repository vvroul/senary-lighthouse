# author: Vrouliotis Vasileios

# IMAGE: lighthouse.png

// Global variables
VAR red_key_acquired = false
VAR familiar_face = false
VAR team = ""
VAR interruption = ""
VAR store_room = false
VAR bed_room = false
VAR service_room = false
VAR first_room_done = false
VAR second_room_done = false
VAR third_room_done = false
VAR room_counter = 0
VAR blame_counter = 0

// starting from intro knot
-> intro

// intro knot
=== intro ===
You wake up in a dark room, <> 
hearing a weird noise. <>
-> intro_choices

// intro choices knot
=== intro_choices ===
   * [Look around ] -> look_around
   * [Open the door] -> open_door
   * [Follow the noise] -> follow_noise
-> end

// open door knot
=== open_door ===
The door is locked.
-> intro_choices

// stand up knot
=== look_around ===
You look around in the darkness. <>
There's a window from which you observe a <> 
light in the distance. Suddenly, it comes to you. <>
A mysterious person visited you last night <>
and at a moment's notice, you fell paralyzed <>
on the ground.
* [Remember the words] -> remember_words
* [Remember the face.] -> remember_face
-> DONE

// remember the words stitch
= remember_words
You try to remember his words. <>
"Consider this a privilege. You have been chosen." <>
As you try to comprehend the meaning behind this, <>
water is slowly filling up the room.
-> fighting_water

// remember the face stitch
= remember_face
You try to remember his face. <>
He was wearing a black gas mask, fully covering his <>
face. As you try to sort out his image inside your <>
head, water is slowly filling up the room.
-> fighting_water

// follow noise knot
=== follow_noise ===
You are following the unpleasant <> 
sound coming from the back of the room. <>
Shortly after, you come across a broken <>
water tank.
-> noise_choices

// noise choices stitch
= noise_choices 
* [Put your hand inside the tank] -> hand_in_tank
* [Start screaming] -> scream
-> DONE

// hand in tank stitch
= hand_in_tank
~red_key_acquired = true
You find a red key with a number marked on it. <>
As you are pulling it out of the tank, water is <>
slowly filling up the room.
-> fighting_water

// scream stitch
= scream
Screaming doesn't help you enough.
-> noise_choices

// fighting water knot
=== fighting_water ===
Panicked, you start running to the door. <>
{ red_key_acquired == true : 
    You manage to unlock it using <>
    the red key and you leave the room.
    -> living_room
 - else : -> lighthouse_choices
}  
-> DONE

// lighthouse choices knot
=== lighthouse_choices ===
  * [Search your pockets ] -> search_pockets
  * [Break the window] -> break_window
-> DONE

// search pockets stitch
=search_pockets
You find a letter and a red key inside your pockets. <>
You manage to unlock the door using the red key <>
and you leave the room.
-> living_room

// break window stitch
=break_window
Breaking the window makes you fully aware of your <>
location. You are located inside a lighthouse. <>
With this information in mind, you manage <>
to climb to the upper floor.
-> living_room

// living room knot
=== living_room ===
You arrive at a room in which there are 3 people and a dead body. <>
One of them is a well known wrestler, the second one is a talented <>
chef and the third one is a thief.

// initial dialog
Mystrerious Voice # CLASS: dialog_char
 "We were waiting for you." # CLASS: dialog
	* [What is going on?]
        You # CLASS: you
        "What... what is going on? <>
        What's with the dead body?" # CLASS: dialog
	    Mystrerious Voice # CLASS: dialog_char
        "I'm going to explain everything, <> 
        don't you worry." # CLASS: dialog
    * [I recognize the dead body.]
        ~familiar_face = true
        You # CLASS: you
        "Wait a minute! I recognize the dead <>
        body's face. That's... # CLASS: dialog
        Mystrerious Voice # CLASS: dialog_char
        "Let's not rush into conclusions  <>
        just yet." # CLASS: dialog
- Mystrerious Voice # CLASS: dialog_char
    "Welcome. I've gathered all of you here in order to complete <>
    my mission. To find the killer of this body." # CLASS: dialog
    "You can call me, The Professor. Now... the rules are simple. <>
    As some of you may have noticed, you are inside a lighthouse." # CLASS: dialog
    * [The Chef interrupts]
        Chef # CLASS: chef
        "We can't really concentrate in what you're saying <>
        withoug having eaten anything for hours!" # CLASS: dialog
    * [The Wrestler interrupts]
        Wrestler # CLASS: wrestler
        "Wherever you are, cut it out now! I'm bored  <>
        hearing about this nonsense." # CLASS: dialog
    * [The Thief interrupts]
        Thief # CLASS: thief
        "Yeah yeah, we already now about that, <>
        now give us the money!" # CLASS: dialog
- The Professor # CLASS: dialog_char
    "Please, my little students. Don't interrupt me again <>
    or else..." # CLASS: dialog
    "You four monsters are all suspects in this case. <>
    So, what we're going to do, is play a game. <> 
    You have one hour to find out who killed this person. <>
    If you don't succeed... well, you all die! Hahahaha! <>
    I'm going to give you the first clue: The murder happened <>
    inside this lighthouse. Good luck." # CLASS: dialog
Chef #CLASS: chef 
    "Finally! Now that this Professor is gone for now, I <>
    suggest we should split up in two teams in order to find <>
    the clues faster. # CLASS: dialog
    -> team_choices
    
// team choices knot
=== team_choices ===
    * [Team up with Chef]
    ~team = "chef"
    -> exploration_choices
    * [Team up with Wrestler]
    ~team = "wrestler"
    -> exploration_choices
    * [Team up with Thief]
    ~team = "thief"
    -> exploration_choices

=== exploration_choices === 
Thief # CLASS: thief
"Why should we trust you? How we know you are not the <>
real killer?" # CLASS: dialog
Wrestler # CLASS: wrestler
"Please don't make it any difficult than it <>
already is. We still don't know anything about <>
the Professor or the victim." # CLASS: dialog
Chef # CLASS: chef
"And there's only an hour left, I remind you." # CLASS: dialog
You # CLASS: you
"That's right! So, my team will first go to : " # CLASS: dialog
-> room_choices

// room choices knot
=== room_choices ===
    * [Store Room]
    ~store_room = true
    ~bed_room = false
    ~service_room = false
    { room_counter > 0 :
      { room_counter == 2 : 
        -> third_room_exploration
        - else :
        -> second_room_exploration
       }
      - else :
        -> first_room_exploration
    }
    * [Bed Room]
    ~bed_room = true
     ~store_room = false
    ~service_room = false
    { room_counter > 0 :
      { room_counter == 2 : 
        -> third_room_exploration
        - else :
        -> second_room_exploration
       }
      - else :
        -> first_room_exploration
    }
    * [Service Room]
    ~service_room = true
    ~store_room = false
    ~bed_room = false
    { room_counter > 0 :
      { room_counter == 2 : 
        -> third_room_exploration
        - else :
        -> second_room_exploration
       }
      - else :
        -> first_room_exploration
    }
-> DONE

// first room exploration knot
=== first_room_exploration ===
~room_counter = room_counter + 1
{ store_room == true :
   As you enter the store room, you notice <>
   some wires on the floor, a ladder and many <>
   cupboards.
   -> store_room_choices
}
{ bed_room == true :
   As you enter the bed room, you notice <>
   that the sheets have a red mark on them <>
   and you hear a weird noise from the toilet. <>
   There's also some leftover food on a plate.
   -> bed_room_choices
}
{ service_room == true :
   As you enter the service room, you notice a <>
   painting on the wall, a broken lamp and a sofa.
   -> service_room_choices
}

// second room exploration knot
=== second_room_exploration ===
~room_counter = room_counter + 1
{ store_room == true :
   As you enter the store room, you notice <>
   some wires on the floor, a ladder and many <>
   cupboards.
   -> store_room_choices
}
{ bed_room == true :
   As you enter the bed room, you notice <>
   that the sheets have a red mark on them <>
   and you hear a weird noise from the toilet. <>
   There's also some leftover food on a plate.
   -> bed_room_choices
}
{ service_room == true :
   As you enter the service room, you notice a <>
   painting on the wall, a broken lamp and a sofa.
   -> service_room_choices
}
-> gathering_2

// third room exploration knot
=== third_room_exploration ===
~room_counter = room_counter + 1
{ store_room == true :
   As you enter the store room, you notice <>
   some wires on the floor, a ladder and many <>
   cupboards.
   -> store_room_choices
}
{ bed_room == true :
   As you enter the bed room, you notice <>
   that the sheets have a red mark on them <>
   and you hear a weird noise from the toilet. <>
   There's also some leftover food on a plate.
   -> bed_room_choices
}
{ service_room == true :
   As you enter the service room, you notice a <>
   painting on the wall, a broken lamp and a sofa.
   -> service_room_choices
}
-> gathering_3

// store room choices
=== store_room_choices ===
* [Examine the wires]
-> store_room_wires
* [Examine the ladder]
-> store_room_ladder
* [Examine the cupboards]
-> store_room_cupboards
* { room_counter == 1 }  -> gathering_1
* { room_counter == 2 }  -> gathering_2
* { room_counter == 3 }  -> gathering_3

=== store_room_wires === 
You examine the wires.
  { team == "thief" : 
    Thief # CLASS: thief
    "Hey, watch out for these wires, they seem to be wet." # CLASS: dialog
    You # CLASS: you
    "Thank you, that was close! But this is suspicious. Who <>
    would just leave some wet wires on the floor?" # CLASS: dialog
    Thief # CLASS: thief
    "I'd surely do, If I wanted to keep something hidden in here." # CLASS: dialog
    ~first_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "This seems suspicious. Who would just leave wires on the floor?" # CLASS: dialog
    Chef # CLASS: chef
    "Indeed, I think we should note that." # CLASS: dialog
    Chef # CLASS: chef
    "Which reminds me, it's time to drink water, I feel too dehydrated." # CLASS: dialog
    ~first_room_done = true
    - else :
    You # CLASS: you
    "This seems suspicious. Who would just leave wires on the floor?" # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Let me try to pull them out." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Ahh, it's not working, they're too far inside." # CLASS: dialog
    }
    ~first_room_done = true
   }
-> store_room_choices

=== store_room_ladder ===
You examine the ladder.
  { team == "thief" : 
    Thief # CLASS: thief
    "Look at that, I was right! A ladder!" # CLASS: dialog
    You # CLASS: you
    "Yes, it's just a ladder, what about that?" # CLASS: dialog
    Thief # CLASS: thief
    "The killer may be using it to store something in a place <>
    we can't reach." # CLASS: dialog
    You # CLASS: you
    "Good point, although maybe this place is not in here." # CLASS: dialog
    ~first_room_done = true
  - else :
    { team == "chef" : 
    Chef # CLASS: chef
    "Well, since we're in the store room, is the most common for <>
    a ladder to be in here." # CLASS: dialog
    You # CLASS: you
    "I'm not sure, only the fact that we're playing this game, <>
    makes me question everything." # CLASS: dialog
    ~first_room_done = true
    - else :
    You # CLASS: you
    "Well, since we're in the store room, is the most common for <>
    a ladder to be in here." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Let us think for a moment. Is there anywhere in the lighthouse <>
    where this ladder could be useful?" # CLASS: dialog
    You # CLASS: you
    "You're probably right, this place is too confined for <> 
    a ladded." # CLASS: dialog
    }
    ~first_room_done = true
   }
-> store_room_choices

=== store_room_cupboards ===
You examine the cupboards.
  { team == "thief" : 
    Thief # CLASS: thief
    "All these cupboards... stay alerted while I'm searching <>
    trough them." # CLASS: dialog
    You # CLASS: you
    "Let me help you." # CLASS: dialog
    Thief # CLASS: thief
    "No, there might be some trap, stay away." # CLASS: dialog
    After an hour of searching...
    Thief # CLASS: thief
    "Found it, hahaha! Always having a lockpick with me! <>
    This is the document we are looking for!" # CLASS: dialog
    The title reads : "Danny Bay Natler, a wonderful lighthouse keeper."
    You # CLASS: you
    "The dead body must belong to this man. <>
    Hurry, we have to report this!" # CLASS: dialog
    ~first_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "Let's search inside these cupboards, shall we?" # CLASS: dialog
    Chef # CLASS: chef
    "Yeah, let me help you." # CLASS: dialog
    After an hour of searching...
    Chef # CLASS: chef
    "It seems there's a locked cupboard, we may need help with that." # CLASS: dialog
     You # CLASS: you
    "Yes, let's just report it for now, I don't think there's anything <>
    worth the effort." # CLASS: dialog
    ~first_room_done = true
    - else :
    You # CLASS: you
    "Let's search inside these cupboards, shall we?" # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Yes, let me help you." # CLASS: dialog
    After an hour of searching...
    Wrestler # CLASS: wrestler
    "This is the last one, but it's locked. What <>
    do you say, should I smash it?" # CLASS: dialog
    You # CLASS: you
    "Better not damage any evidence, let's just <>
    go back and report it." # CLASS: dialog
    }
    ~first_room_done = true
   }
-> store_room_choices


//bed room choices 
=== bed_room_choices ===
* [Examine the sheets]
-> bed_room_sheets
* [Examine the toilet]
-> bed_room_toilet
* [Examine the leftover food]
-> bed_room_leftovers
* { room_counter == 1 }  -> gathering_1
* { room_counter == 2 }  -> gathering_2
* { room_counter == 3 }  -> gathering_3

=== bed_room_sheets === 
You examine the sheets.
  { team == "thief" : 
    Thief # CLASS: thief
    "Do you see this red mark? Is it blood?" # CLASS: dialog
    You # CLASS: you
    "It doesn't seem like it, even from the smell." # CLASS: dialog
    Thief # CLASS: thief
    "It's not fresh, more likely a week has passed after the <>
    incident." # CLASS: dialog
    You # CLASS: you
    "So the murder maybe took place in this room. <>
    Let's search for more clues!" # CLASS: dialog
    ~second_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "Do you see this red mark? Is it blood?" # CLASS: dialog
    Chef # CLASS: chef
    "It doesn't seem like it, even from the smell." # CLASS: dialog
    You # CLASS: you
    "It's not fresh, more likely a week has passed after the <>
    incident." # CLASS: dialog
    Chef # CLASS: chef
    "Maybe the killer wanted to trick us with this mark and make <>
    us believe that this is the murder room." # CLASS: dialog
    You # CLASS: you
    "Let's search for more clues!" # CLASS: dialog
    ~second_room_done = true
    - else :
    You # CLASS: you
    "Do you see this red mark? Is it blood?" # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Blood? Did you say blood? I'm diagnosed with hemophobia <>
    so I'll take a step back." # CLASS: dialog
    You # CLASS: you
    "Either way, the murder maybe took place in this room. <>
    Let's search for more clues!" # CLASS: dialog
    }
    ~second_room_done = true
   }
-> bed_room_choices

=== bed_room_toilet === 
You examine the toilet.
  { team == "thief" : 
    Thief # CLASS: thief
    "Seems like an ordinary toilet to me." # CLASS: dialog
    You # CLASS: you
    "That sound... I'm sure I've heard it before." # CLASS: dialog
    Thief # CLASS: thief
    "I can't hear anything, let's get out of here." # CLASS: dialog
    ~second_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "That sound... I'm sure I've heard it before." # CLASS: dialog
    Chef # CLASS: chef
    "Indeed. When we were locked inside that room." # CLASS: dialog
    You # CLASS: you
    "Wait a minute, you were also locked in a dark room?" # CLASS: dialog
    Chef # CLASS: chef
    "All of us. We were abducted from our houses and then <>
    transfered here. The Professor told us these details before <>
    you showed up." # CLASS: dialog
    ~second_room_done = true
    - else :
    You # CLASS: you
    "Seems like an ordinary toilet to me." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "At least there's no blood in here. Hey, <>
    did you hear a creepy sound coming from the inside?" # CLASS: dialog
    You # CLASS: you
    "Whatever it was, it stopped for now." # CLASS: dialog
    }
    ~second_room_done = true
   }
-> bed_room_choices

=== bed_room_leftovers === 
You examine the leftovers.
  { team == "thief" : 
    You # CLASS: you
    "Oh no..." # CLASS: dialog
    Thief # CLASS: thief
    "We had the same thought. Poisoned food with murder <>
    is a match made in heaven." # CLASS: dialog
    You # CLASS: you
    "I agree. But, did you notice the quantity of the leftovers? <>
    If the person was poisoned, he wouldn't continue eating." # CLASS: dialog
    Thief # CLASS: thief
    "That's a thing. Let's go back and report it." # CLASS: dialog
    ~second_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "Oh no..." # CLASS: dialog
    Chef # CLASS: chef
    "They poisoned the food, there's no doubt about that!" # CLASS: dialog
    You # CLASS: you
    "How can you be so sure?" # CLASS: dialog
    Chef # CLASS: chef
    "Well, I don't know if you noticed the body. There wasn't any <>
    bleeding or bruises on it. So being poisoned is highly possible." # CLASS: dialog
    You # CLASS: you
    "You're right. Let's go back and report it." # CLASS: dialog
    ~second_room_done = true
    - else :
    You # CLASS: you
    "Oh no..." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "The food. Don't tell me they poisoned the food..." # CLASS: dialog
    You # CLASS: you
    "It is highly possible. But then again..." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Seems like there's so little left, for poisoned food." # CLASS: dialog
    You # CLASS: you
    "That's a thing. Let's go back and report it." # CLASS: dialog
    }
    ~second_room_done = true
   }
-> bed_room_choices


// service room choices
=== service_room_choices ===
* [Examine the painting]
-> service_room_painting
* [Examine the lamp]
-> service_room_lamp
* [Examine the sofa]
-> service_room_sofa
* { room_counter == 1 }  -> gathering_1
* { room_counter == 2 }  -> gathering_2
* { room_counter == 3 }  -> gathering_3

=== service_room_painting === 
You examine the painting.
  { team == "thief" : 
    Thief # CLASS: thief
    "All these famous paintings and not a single one <>
    that we can steal." # CLASS: dialog
    You # CLASS: you
    "Please focus on our mission. # CLASS: dialog
    Thief # CLASS: thief
    "I'm trying you know!" # CLASS: dialog
    ~third_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "This painting is representative for every lighthouse <>
    in the world." # CLASS: dialog
    Chef # CLASS: chef
    "It must have a deeper meaning..." # CLASS: dialog
    ~third_room_done = true
    - else :
    You # CLASS: you
    "This painting is representative for every lighthouse <>
    in the world." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Maybe if try to move it a little bit? Here we go!" # CLASS: dialog
    You # CLASS: you
    "What... what's that hole in the wall?" # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Probably the killer hid that hole for a reason. <> We 
    should report it." # CLASS: dialog
    }
    ~third_room_done = true
   }
-> service_room_choices

=== service_room_lamp === 
You examine the lamp.
  { team == "thief" : 
    Thief # CLASS: thief
    "Once I smashed a lamp on a partner's head <>
    because he was so stupid and they put is in jail <>
    because of that." # CLASS: dialog
    You # CLASS: you
    "That sounds... hilarious." # CLASS: dialog
    Thief # CLASS: thief
    "Yet, this lamp could have broken in many possible <>
    ways." # CLASS: dialog
    ~third_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "Just a broken lamp..." # CLASS: dialog
    Chef # CLASS: chef
    "While broken, it slightly working, should we carry it <>
    for a little bit in case we need it?" # CLASS: dialog
    You # CLASS: you
    "Of course, you can carry it around." # CLASS: dialog
    - else :
    You # CLASS: you
    "Just a broken lamp..." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Wait. There's something suspicious here. <>
    If we are the first ones coming here without <>
    removing any evidence, then the floor should be <>
    filled with pieces of this broken lamp!" # CLASS: dialog
    You # CLASS: you
    "You are a genius! So, someone else must have gotten <>
    here before us and took the pieces." # CLASS: dialog
    }
    ~third_room_done = true
   }
-> service_room_choices

=== service_room_sofa === 
You examine the sofa.
  { team == "thief" : 
    Thief # CLASS: thief
    "So, one thing you should now, is that I'm not <>
    the killer." # CLASS: dialog
    You # CLASS: you
    "And why say that now?" # CLASS: dialog
    Thief # CLASS: thief
    "Because if I was the killer, I would come to this place <>
    looked at that comfy sofa and just leave with it without <>
    the need of murdering anyone." # CLASS: dialog
    You # CLASS: you
    "Your tricks won't work on me!" # CLASS: dialog
    ~third_room_done = true
  - else :
    { team == "chef" : 
    You # CLASS: you
    "Let's search in between the cushions, they might hide <>
    a clue." # CLASS: dialog
    Chef # CLASS: chef
    "Aldready did, there's absolutely nothing." # CLASS: dialog
    You # CLASS: you
    "This room is totally empty of evidence." # CLASS: dialog
    ~third_room_done = true
    - else :
    You # CLASS: you
    "Let's search in between the cushions, they might hide <>
    a clue." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Are you kidding, I'm going to lift this sofa for as <>
    long as I can, and you will search underneath it ok?" # CLASS: dialog
    You # CLASS: you
    "Agreed, let's do this." # CLASS: dialog
    You # CLASS: you
    "I... I can't believe it... it's another dead body." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "How is that possible..." # CLASS: dialog
    You # CLASS: you
    "This looks like a professor, right? Maybe... all this <>
    time...we should go back, the others need to know." # CLASS: dialog
    }
    ~third_room_done = true
   }
-> service_room_choices

//gathering 1 knot
=== gathering_1 ===
All the suspects are gathered in the living room.
{ store_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Guys, we found something really important about the case!" # CLASS: dialog
    Thief # CLASS: thief
    "Of course, thanks to my incredible stealing skills! <>
    You see, the victim of the case seems to be the former <>
    lighthouse keeper!" # CLASS: dialog
    Chef # CLASS: chef
    "That's really strange. I wonder what was the reason behind <>
    this murder." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Indeed. We searched the bed room area, but didn't find anything <>
    of interest. You should also check it out." # CLASS: dialog
    - else :
        { team == "chef" : 
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "We only found a locked cupboard what could be useful <>
        but didn't manage to open it." # CLASS: dialog
        Thief # CLASS: thief
        "We have a suspicion about who the Professor might be." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "Exactly, we searched around the service room area and some <>
        clues are connecting the Professor with the lighthouse owner. <>
        Better check this out for yourselves too!" # CLASS: dialog
        - else :
            You # CLASS: you
            "Did you find any important clue?" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "We only found a locked cupboard what could be useful <>
            but didn't manage to open it." # CLASS: dialog
            Chef # CLASS: chef
            "We have a suspicion about who the Professor might be." # CLASS: dialog
            Thief # CLASS: thief
            "Exactly, we searched around the service room area and some <>
            clues are connecting the Professor with the lighthouse owner. <>
            Better check this out for yourselves too!" # CLASS: dialog
        }
    }
}
{ bed_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Did you find any important clue?" # CLASS: dialog
    Thief # CLASS: thief
    "We searched around bed room area, there was a red <>
    mark and possibly some poisoned food." # CLASS: dialog
    Chef # CLASS: chef
    "Poison huh? That's interesting. We searched around the <>
    service room and found some clues which connect the Professor <>
    with the lighthouse owner." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Indeed. Although, you might want to check that room also." # CLASS: dialog
    - else :
        { team == "chef" :
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "We are totally convinced that the killer poisoned <>
        the victim. There was some poisoned food at the bed <>
        room area and that explains the nonexistence of <>
        bleeding and bruises of the dead body." # CLASS: dialog
        Thief # CLASS: thief
        "Nice job! We went to the store room and we only made <>
        some theories." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "There was nothing inside this place. Although, the ladder...<>
        it could be used for escape if placed correctly." # CLASS: dialog
        - else :
            You # CLASS: you
            "Did you find any important clue?" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "We searched around bed room area, there was blood <>
            and possibly some poisoned food."# CLASS: dialog
            You # CLASS: you
            "There was no blood, don't be afraid..." # CLASS: dialog
            Thief # CLASS: thief
            "Poison huh? That's interesting. We went to the store room <>
            and we only made some theories." # CLASS: dialog
            Chef # CLASS: chef
            "There was nothing inside this place..." # CLASS: dialog
        }
    }
}
{ service_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Did you find any important clue?" # CLASS: dialog
    Thief # CLASS: thief
    "We were only saying spooky stories and jokes all the time!" # CLASS: dialog
    Chef # CLASS: chef
    "Same here for us, we were playing with every little thing <>
    inside the store room." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Where were you though? I was searching for you!" # CLASS: dialog
    Chef # CLASS: chef
    "I was behind you silly!" # CLASS: dialog
    - else :
        { team == "chef" : 
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "For us, it was like walking into darkness." # CLASS: dialog
        Thief # CLASS: thief
        "Well, we did search the bed room and found the <>
        food also." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "But we're not sure if it was poisoned or not, it was <>
        so little left." # CLASS: dialog
        - else :
            You # CLASS: you
            "Guys, we found something really important about <>
            the case!" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "Actually... we found another dead body in the service <>
            room area." # CLASS: dialog
            Chef # CLASS: chef
            "Another... dead body?" # CLASS: dialog
            Thief # CLASS: thief
            "Well, we have ourselves a mystery." # CLASS: dialog
            Chef # CLASS: chef
            "I can't believe it..." # CLASS: dialog
        }
    }
}
You # CLASS: you
"Ok, so where should we go now?" # CLASS: dialog
-> room_choices

//gathering 2 knot
=== gathering_2 ===
All the suspects are gathered in the living room.
{ store_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Guys, we found something really important about the case!" # CLASS: dialog
    Thief # CLASS: thief
    "Of course, thanks to my incredible stealing skills! <>
    You see, the victim of the case seems to be the former <>
    lighthouse keeper!" # CLASS: dialog
    Chef # CLASS: chef
    "That's really strange. I wonder what was the reason behind <>
    this murder." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Indeed. We searched the bed room area, but didn't find anything <>
    of interest. You should also check it out." # CLASS: dialog
    - else :
        { team == "chef" : 
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "We only found a locked cupboard what could be useful <>
        but didn't manage to open it." # CLASS: dialog
        Thief # CLASS: thief
        "We have a suspicion about who the Professor might be." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "Exactly, we searched around the service room area and some <>
        clues are connecting the Professor with the lighthouse owner. <>
        Better check this out for yourselves too!" # CLASS: dialog
        - else :
            You # CLASS: you
            "Did you find any important clue?" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "We only found a locked cupboard what could be useful <>
            but didn't manage to open it." # CLASS: dialog
            Chef # CLASS: chef
            "We have a suspicion about who the Professor might be." # CLASS: dialog
            Thief # CLASS: thief
            "Exactly, we searched around the service room area and some <>
            clues are connecting the Professor with the lighthouse owner. <>
            Better check this out for yourselves too!" # CLASS: dialog
        }
    }
}
{ bed_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Did you find any important clue?" # CLASS: dialog
    Thief # CLASS: thief
    "We searched around bed room area, there was a red <>
    mark and possibly some poisoned food." # CLASS: dialog
    Chef # CLASS: chef
    "Poison huh? That's interesting. We searched around the <>
    service room and found some clues which connect the Professor <>
    with the lighthouse owner." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Indeed. Although, you might want to check that room also." # CLASS: dialog
    - else :
        { team == "chef" :
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "We are totally convinced that the killer poisoned <>
        the victim. There was some poisoned food at the bed <>
        room area and that explains the nonexistence of <>
        bleeding and bruises of the dead body." # CLASS: dialog
        Thief # CLASS: thief
        "Nice job! We went to the store room and we only made <>
        some theories." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "There was nothing inside this place. Although, the ladder...<>
        it could be used for escape if placed correctly." # CLASS: dialog
        - else :
            You # CLASS: you
            "Did you find any important clue?" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "We searched around bed room area, there was blood <>
            and possibly some poisoned food."# CLASS: dialog
            You # CLASS: you
            "There was no blood, don't be afraid..." # CLASS: dialog
            Thief # CLASS: thief
            "Poison huh? That's interesting. We went to the store room <>
            and we only made some theories." # CLASS: dialog
            Chef # CLASS: chef
            "There was nothing inside this place..." # CLASS: dialog
        }
    }
}
{ service_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Did you find any important clue?" # CLASS: dialog
    Thief # CLASS: thief
    "We were only saying spooky stories and jokes all the time!" # CLASS: dialog
    Chef # CLASS: chef
    "Same here for us, we were playing with every little thing <>
    inside the store room." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Where were you though? I was searching for you!" # CLASS: dialog
    Chef # CLASS: chef
    "I was behind you silly!" # CLASS: dialog
    - else :
        { team == "chef" : 
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "For us, it was like walking into darkness." # CLASS: dialog
        Thief # CLASS: thief
        "Well, we did search the bed room and found the <>
        food also." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "But we're not sure if it was poisoned or not, it was <>
        so little left." # CLASS: dialog
        - else :
            You # CLASS: you
            "Guys, we found something really important about <>
            the case!" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "Actually... we found another dead body in the service <>
            room area." # CLASS: dialog
            Chef # CLASS: chef
            "Another... dead body?" # CLASS: dialog
            Thief # CLASS: thief
            "Well, we have ourselves a mystery." # CLASS: dialog
            Chef # CLASS: chef
            "I can't believe it..." # CLASS: dialog
        }
    }
}
You # CLASS: you
"Ok, so where should we go now?" # CLASS: dialog
-> room_choices

//gathering 3 knot
=== gathering_3 ===
All the suspects are gathered in the living room.
{ store_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Guys, we found something really important about the case!" # CLASS: dialog
    Thief # CLASS: thief
    "Of course, thanks to my incredible stealing skills! <>
    You see, the victim of the case seems to be the former <>
    lighthouse keeper!" # CLASS: dialog
    Chef # CLASS: chef
    "That's really strange. I wonder what was the reason behind <>
    this murder." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Indeed. We searched the bed room area, but didn't find anything <>
    of interest. You should also check it out." # CLASS: dialog
    - else :
        { team == "chef" : 
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "We only found a locked cupboard what could be useful <>
        but didn't manage to open it." # CLASS: dialog
        Thief # CLASS: thief
        "We have a suspicion about who the Professor might be." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "Exactly, we searched around the service room area and some <>
        clues are connecting the Professor with the lighthouse owner. <>
        Better check this out for yourselves too!" # CLASS: dialog
        - else :
            You # CLASS: you
            "Did you find any important clue?" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "We only found a locked cupboard what could be useful <>
            but didn't manage to open it." # CLASS: dialog
            Chef # CLASS: chef
            "We have a suspicion about who the Professor might be." # CLASS: dialog
            Thief # CLASS: thief
            "Exactly, we searched around the service room area and some <>
            clues are connecting the Professor with the lighthouse owner. <>
            Better check this out for yourselves too!" # CLASS: dialog
        }
    }
}
{ bed_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Did you find any important clue?" # CLASS: dialog
    Thief # CLASS: thief
    "We searched around bed room area, there was a red <>
    mark and possibly some poisoned food." # CLASS: dialog
    Chef # CLASS: chef
    "Poison huh? That's interesting. We searched around the <>
    service room and found some clues which connect the Professor <>
    with the lighthouse owner." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Indeed. Although, you might want to check that room also." # CLASS: dialog
    - else :
        { team == "chef" :
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "We are totally convinced that the killer poisoned <>
        the victim. There was some poisoned food at the bed <>
        room area and that explains the nonexistence of <>
        bleeding and bruises of the dead body." # CLASS: dialog
        Thief # CLASS: thief
        "Nice job! We went to the store room and we only made <>
        some theories." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "There was nothing inside this place. Although, the ladder...<>
        it could be used for escape if placed correctly." # CLASS: dialog
        - else :
            You # CLASS: you
            "Did you find any important clue?" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "We searched around bed room area, there was blood <>
            and possibly some poisoned food."# CLASS: dialog
            You # CLASS: you
            "There was no blood, don't be afraid..." # CLASS: dialog
            Thief # CLASS: thief
            "Poison huh? That's interesting. We went to the store room <>
            and we only made some theories." # CLASS: dialog
            Chef # CLASS: chef
            "There was nothing inside this place..." # CLASS: dialog
        }
    }
}
{ service_room == true :
    { team == "thief" : 
    You # CLASS: you
    "Did you find any important clue?" # CLASS: dialog
    Thief # CLASS: thief
    "We were only saying spooky stories and jokes all the time!" # CLASS: dialog
    Chef # CLASS: chef
    "Same here for us, we were playing with every little thing <>
    inside the store room." # CLASS: dialog
    Wrestler # CLASS: wrestler
    "Where were you though? I was searching for you!" # CLASS: dialog
    Chef # CLASS: chef
    "I was behind you silly!" # CLASS: dialog
    - else :
        { team == "chef" : 
        You # CLASS: you
        "Did you find any important clue?" # CLASS: dialog
        Chef # CLASS: chef
        "For us, it was like walking into darkness." # CLASS: dialog
        Thief # CLASS: thief
        "Well, we did search the bed room and found the <>
        food also." # CLASS: dialog
        Wrestler # CLASS: wrestler
        "But we're not sure if it was poisoned or not, it was <>
        so little left." # CLASS: dialog
        - else :
            You # CLASS: you
            "Guys, we found something really important about <>
            the case!" # CLASS: dialog
            Wrestler # CLASS: wrestler
            "Actually... we found another dead body in the service <>
            room area." # CLASS: dialog
            Chef # CLASS: chef
            "Another... dead body?" # CLASS: dialog
            Thief # CLASS: thief
            "Well, we have ourselves a mystery." # CLASS: dialog
            Chef # CLASS: chef
            "I can't believe it..." # CLASS: dialog
        }
    }
}
-> final_verdict 

=== final_verdict ===
The Professor # CLASS: dialog_char
    "Diing dong! Time's already up, little mouses. <>
    So tell me. Which one of you, is the real killer?" # CLASS: dialog
-> killer_choices

=== killer_choices ===
The killer is...
    * [The Chef]
    ~team = "chef"
    -> blame_chef
    * [The Wrestler]
    ~team = "wrestler"
    -> blame_wrestler
    * [The Thief]
    ~team = "thief"
    -> blame_thief
-> DONE


=== blame_thief ===
Thief # CLASS: thief
"You know... I understand right, I'm a thief. But that <>
does not mean I like killing people. I understand why <>
you chose me. You are really clever. Except that... I'm <>
not the real killer." # CLASS: dialog
-> killer_choices

=== blame_wrestler ===
Wrestler # CLASS: wrestler
"You have all the right in the world to blame me. <>
But, the night in which the murder took place, I was <>
having a tournament match. Of course, I can prove it <>
from the camera footage. So, sorry to break it to you, <>
but I'm not the real killer." # CLASS: dialog
-> killer_choices

=== blame_chef ===
The Professor # CLASS: dialog_char
    "Let me do the talking instead... You probably <>
    have noticed that there's a little twist in this <>
    case. Am I right?" # CLASS: dialog
    * [Second dead body]
        You # CLASS: you
        "You're talking about the second dead body." # CLASS: dialog
    - The Professor # CLASS: dialog_char
    You're a clever one. Yes If you did your search well, <>
    you found a second dead body under the sofa in the service <>
    room. Well... I was the killer of this one. BUT. But, but, but... <>
    Chef... you killed my father don't you? # CLASS: dialog
    Chef # CLASS: chef
    "Hahaha, you think I'm a killer? Do you even have evidence about <>
    about what you're saying?" # CLASS: dialog
    You # CLASS: you
    "I have..." # CLASS: dialog
    -> blame_choices
-> DONE

=== blame_choices === 
* [Poisoned Food] -> poison
* [Abductions] -> abductions
* [Sudden disappearance] -> disappear
-> fin

=== poison ===
~blame_counter = blame_counter + 1
You # CLASS: you
"You were the only one from the suspects who insisted <>
about the poisoning. The reason behind this was that you <>
wanted to convince us that there were no bruises on the body. <>
But, Professor, do you mind I turn the body around?" # CLASS: dialog
The Professor # CLASS: dialog_char
    "No objection." # CLASS: dialog
You # CLASS: you
"As we can clearly see, there are a lot of bruises at the back <>
of the body. Only the real killer could have known this information <>
and try to misguide the others." # CLASS: dialog
{blame_counter == 3 :
    -> fin
  - else:
    -> blame_choices
}


=== abductions ===
~blame_counter = blame_counter + 1
You # CLASS: you
"You were the only one from the suspects who knew beforehand <> 
that we all had been abducted at the same day from the Professor <>
and not only that but... Chef, it's not your first time here, is it?" <>
You also cleared some evidence from the service room. The broken lamp <>
pieces...# CLASS: dialog
{blame_counter == 3 :
    -> fin
  - else:
    -> blame_choices
}


=== disappear ===
~blame_counter = blame_counter + 1
You # CLASS: you
"Wrestler told us about your sudden disappearance while he <>
was searching for clues in the store area. Where were you?" # CLASS: dialog
Chef # CLASS: chef
"I was in store room, behind him, all the time." # CLASS: dialog
You # CLASS: you
"No! You were at the lantern...The highest place in the lighthouse. <>
And I have no doubt you used the ladder to get up there!" # CLASS: dialog
You # CLASS: you
"You were trying to escape from the lighthouse all that time." # CLASS: dialog
{blame_counter == 3 :
    -> fin
  - else:
    -> blame_choices
}

=== fin === 
You # CLASS: you
So for the all the reasons above...you are the killer. # CLASS: dialog
Chef # CLASS: chef
"Nooo... it can't be... I had it all so well organized." # CLASS: dialog
You # CLASS: you
"Well, it seems that you will keep things organized in the jail." # CLASS: dialog
-> end

//end knot
=== end ===
_________ THE END _________
Thank you for playing!
-> END