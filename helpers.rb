def production_database_config
  db_url_parts = ENV['DATABASE_URL'].split(/\/|:|@/)

  {
    user: db_url_parts[3],
    password: db_url_parts[4],
    host: db_url_parts[5],
    dbname: db_url_parts[7]
  }
end

configure :development do
  set :database_config, { dbname: 'rubyracer' }
end

configure :production do
  set :database_config, production_database_config
end

def db_connection
  begin
    connection = PG.connect(settings.database_config)
    yield(connection)
  ensure
    connection.close
  end
end

def save_score(name, score, floor, bombs, coins)
  db_connection do |conn|
    query = "INSERT INTO scores (name, score, floor, bombs, coins, created_at)
              VALUES ($1, $2, $3, $4, $5, now())"
    conn.exec_params(query, [name, score, floor, bombs, coins])
  end
end

def find_scores
  db_connection do |conn|
    query = "SELECT scores.id, scores.name, scores.score, scores.floor, scores.bombs,
              scores.coins, scores.created_at
            FROM scores
            ORDER BY scores.score DESC
            LIMIT 100"
    conn.exec(query)
  end
end

def delete_score(id)
  db_connection do |conn|
    query = "DELETE FROM scores WHERE scores.id = $1"
    conn.exec_params(query, [id])
  end
end
