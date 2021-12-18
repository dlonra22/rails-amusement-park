class Ride < ActiveRecord::Base
    belongs_to :user 
    belongs_to :attraction
 

    def take_ride
        if tallenough && enoughtickets
           newtickets = self.user.tickets - self.attraction.tickets
           newhappiness = self.user.happiness + self.attraction.happiness_rating
           newnausea = self.user.nausea + self.attraction.nausea_rating
           self.user.update(tickets: newtickets, happiness: newhappiness, nausea: newnausea)
        end
        comment
    end

    def tallenough
        self.user.height >= self.attraction.min_height ? true : false
    end

    def enoughtickets
        self.user.tickets >= self.attraction.tickets ? true : false
    end
    
    def comment
        cm = ''
        if !tallenough & !enoughtickets
            cm = "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
        elsif !tallenough
            cm = "Sorry. You are not tall enough to ride the #{self.attraction.name}."
        elsif !enoughtickets
            cm = "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
        else
            cm = "Thanks for riding the #{self.attraction.name}!"
        end

        cm
    end


end
