require "csv"


class BaseRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @elements = []

    load_csv if File.exist?(@csv_path)
  end

  def all
    @elements
  end

  def create(element)
    element.id = next_id
    @elements << element

    update_csv
  end

  def find(id)
    @elements.find { |element| element.id == id } # meal instance
  end

  private

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << repo_class.headers
      @elements.each do |element|
        csv << element.to_a
      end
    end
  end

  def next_id
    @elements.empty? ? 1 : @elements.last.id + 1
  end
end
