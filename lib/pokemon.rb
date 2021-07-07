class Pokemon

  attr_accessor :name, :type, :id, :db

  def initialize( id: nil, name:, type:, db: )
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)

    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?,?)
    SQL

    db.execute(sql, name, type)
  end

  def self.find(id_num, db)

    pok_info = db.execute("SELECT * FROM pokemon WHERE id = ?", id_num).flatten

    Pokemon.new(
      id: pok_info[0],
      name: pok_info[1],
      type: pok_info[2], 
      db: db,
    )
  end

end
