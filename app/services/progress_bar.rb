# Genarates progress bar profile
class ProgressBar
  def initialize(profile)
    @profile = profile
  end

  def call
    @progress_bar = 0
    @progress_bar += 40 unless @profile.phones.empty?
    [:name, :city_id].each do |method|
      result = @profile.send(method).to_s
      @progress_bar += 40 unless result.nil? || result.empty?
    end
    @progress_bar
  end
end
