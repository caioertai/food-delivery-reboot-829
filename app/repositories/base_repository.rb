require "csv"


class BaseRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @models = []

    load_csv if File.exist?(@csv_path)
  end

  def all
    @models
  end

  def create(model)
    model.id = next_id
    @models << model

    update_csv
  end

  def find(id)
    @models.find { |model| model.id == id } # meal instance
  end

  private

  def next_id
    @models.empty? ? 1 : @models.last.id + 1
  end
end
