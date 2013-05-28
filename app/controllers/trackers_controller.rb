class TrackersController < ApplicationController
   before_filter :signed_in_user_it, only: [:view, :edit, :options]

  def index
    @tracker = Tracker.find_by_user_index(params[:user_index])
  end

  def geoloc
    @tracker = current_tracker
    dory = []
    File.open("file.txt", "r").each_line do |line|
      dory = line.split(",")
    end

    if dory[1] == 'A'
      toaddlat = dory[2]
      oldpooloflat = @tracker.lat
      mediator = '*'
      if @tracker.lat == nil
        oldpooloflat = ''
        mediator = ''
      elsif @tracker.lat == ''
        oldpooloflat = ''
        mediator = ''
      end
      newpooloflat = oldpooloflat + mediator + toaddlat
      @tracker.update_attribute(:lat, newpooloflat)
      

      toaddlongi = dory[4]
      oldpooloflongi = @tracker.longi
      mediator = '*'
      if @tracker.longi == nil
        oldpooloflongi = ''
        mediator = ''
      elsif @tracker.longi == ''
        oldpooloflongi = ''
        mediator = ''
      end
      newpooloflongi = oldpooloflongi + mediator + toaddlongi
      @tracker.update_attribute(:longi, newpooloflongi)
    end

  end

  def location
    @tracker = Tracker.find_by_user_index(params[:user_index])

    toaddlat = params[:lat]
    oldpooloflat = @tracker.lat
    mediator = '*'
    if @tracker.lat == nil
      oldpooloflat = ''
      mediator = ''
    elsif @tracker.lat == ''
      oldpooloflat = ''
      mediator = ''
    end
    newpooloflat = oldpooloflat + mediator + toaddlat
    @tracker.update_attribute(:lat, newpooloflat)
    

    toaddlongi = params[:longi]
    oldpooloflongi = @tracker.longi
    mediator = '*'
    if @tracker.longi == nil
      oldpooloflongi = ''
      mediator = ''
    elsif @tracker.longi == ''
      oldpooloflongi = ''
      mediator = ''
    end
    newpooloflongi = oldpooloflongi + mediator + toaddlongi
    @tracker.update_attribute(:longi, newpooloflongi)

    @tracker.update_attribute(:carStat, params[:carStat])

    respond_to do |format|
        mixedcoords = @tracker.latlong.to_s.split("*").map { |s| s.to_f }
        everyradius = @tracker.radii.to_s.split("*").map { |s| s.to_f }
        indicator = 1
        latcoords = Array.new
        longcoords = Array.new

        mixedcoords.each do |s|
          if indicator%2 == 1
            latcoords << s
          else
            longcoords << s
          end
          indicator += 1
        end

        outofbounds = 1
        count = 0

        (1..everyradius.length).each do
          everyradius.each do |r|
            curlat = latcoords[count].to_f
            curlong = longcoords[count].to_f
            y = @tracker.lat.to_f
            x = @tracker.longi.to_f
            z = (x - curlong)**2 + (y - curlat)**2
            if z > r
              outofbounds = 1
            elsif
              outofbounds  = 0
            end
          end
          count+=1
        end
      format.xml { render xml: {id: '1', outofbounds: outofbounds} }
      end
  end

  def view
  	@tracker = current_tracker
  end
  def edit
    @tracker = current_tracker
  end
  def update
  	@tracker = Tracker.find_by_user_index(params[:user_index])
    @tracker.update_attribute(:latlong, params[:latlong])
    @tracker.update_attribute(:radii, params[:radii])
    @tracker.update_attribute(:marker_count, params[:marker_count])
    #@tracker.update_attribute(:lat, params[:lat])
    #@tracker.update_attribute(:longi, params[:longi])
    #@tracker.update_attribute(:carStat, params[:carStat])
  end
  def options
    if params[:contacs] == nil
      @tracker = current_tracker
    else
      @tracker = current_tracker
      @tracker.update_attribute(:contacs, params[:contacs])
    end
  end

  private

    def signed_in_user_it
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end

