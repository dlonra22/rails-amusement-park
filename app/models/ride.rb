class Ride < ActiveRecord::Base
    belongs_to :user 
    belongs_to :attraction
    validates :user_id, presence: true 
    validates :attraction_id, presence: true

    def take_ride
        @user = User.find_by(id: self.user_id)
        @attraction = Attraction.find_by(id: self.attraction_id)
        tallenough = false
        enoughtickets = false
        comment = ''

        if @user && @attraction
            enoughtickets = true if @user.tickets >= @attraction.tickets
            tallenough = true if @user.height >= @attraction.min_height
        end

        if tallenough && enoughtickets
            @user.tickets = @user.tickets - @attraction.tickets
            @user.happiness += @attraction.happiness_rating
            @user.nausea += @attraction.nausea_rating
            @user.save
        elsif !tallenough && !enoughtickets
            comment = "Sorry. You do not have enough tickets to ride the #{@attraction.name}. You are not tall enough to ride the #{@attraction.name}."
        elsif !enoughtickets
            comment = "Sorry. You do not have enough tickets to ride the #{@attraction.name}."
        elsif !tallenough
            comment = "Sorry. You are not tall enough to ride the #{@attraction.name}."
        end
        
        comment
    end


end
