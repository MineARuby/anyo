# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "seeds starting"
Opening.destroy_all
Opening.create(i18n_name: 'caro_kann', session_name: 'caro_kann', first_moves: 'e2e4,c7c6')
Opening.create(i18n_name: 'kings_indian_attack', session_name: 'kings_ind_att', first_moves: 'e2e4,e7e6,d2d3,d7d5,b1d2,g8f6,g2g3,c7c5,f1g2,b8c6,g1f3')
Opening.create(i18n_name: 'kings_indian_defence', session_name: 'kings_ind_def', first_moves: 'd2d4,g8f6,c2c4,g7g6,b1c3,f8g7,e2e4,d7d6')
Opening.create(i18n_name: 'queens_indian_defence', session_name: 'queens_ind_def', first_moves: 'd2d4,g8f6,c2c4,e7e6,g1f3,b7b6')
Opening.create(i18n_name: 'dutch_defence', session_name: 'dutch', first_moves: 'd2d4,f7f5')
Opening.create(i18n_name: 'french_defence', session_name: 'french', first_moves: 'e2e4,e7e6')
Opening.create(i18n_name: 'ruy_lopez', session_name: 'ruy_lopez', first_moves: 'e2e4,e7e5,g1f3,b8c6,f1b5')
Opening.create(i18n_name: 'sicilian_defence', session_name: 'sicilian', first_moves: 'e2e4,c7c5')
Opening.create(i18n_name: 'russian_defence', session_name: 'russian', first_moves: 'e2e4,e7e5,g1f3,g8f6')
Opening.create(i18n_name: 'pirc_defence', session_name: 'pirc', first_moves: 'e2e4,d7d6')
Opening.create(i18n_name: 'alekhine_defence', session_name: 'alekhine', first_moves: 'e2e4,g8f6')
Opening.create(i18n_name: 'modern_defence', session_name: 'modern', first_moves: 'e2e4,g7g6')
Opening.create(i18n_name: 'english_game', session_name: 'english', first_moves: 'c2c4')
Opening.create(i18n_name: 'queens_gambit_accepted', session_name: 'queens_gamb_acc', first_moves: 'd2d4,d7d5,c2c4,d5c4')
Opening.create(i18n_name: 'queens_gambit_declined', session_name: 'queens_gamb_decl', first_moves: 'd2d4,d7d5,c2c4,e7e6')
Opening.create(i18n_name: 'slav_defence', session_name: 'slav', first_moves: 'd2d4,d7d5,c2c4,c7c6')
Opening.create(i18n_name: 'kings_gambit', session_name: 'kings_gamb', first_moves: 'e2e4,e7e5,f2f4')
Opening.create(i18n_name: 'vienna_game', session_name: 'vienna', first_moves: 'e2e4,e7e5,b1c3')
Opening.create(i18n_name: 'italian_game', session_name: 'italian', first_moves: 'e2e4,e7e5,g1f3,b8c6,f1c4')
Opening.create(i18n_name: 'trompovsky_attack', session_name: 'trompovsky', first_moves: 'd2d4,g8f6,c1g5')
Opening.create(i18n_name: 'london_system', session_name: 'london', first_moves: 'd2d4,g8f6,c1f4')
Opening.create(i18n_name: 'scotch_game', session_name: 'scotch', first_moves: 'e2e4,e7e5,g1f3,b8c6,d2d4')
Opening.create(i18n_name: 'nimzo_indian_defence', session_name: 'nimzo', first_moves: 'd2d4,g8f6,c2c4,e7e6,b1c3,f8b4')
Opening.create(i18n_name: 'philidor_defence', session_name: 'philidor', first_moves: 'e2e4,e7e5,g1f3,d7d6')
Opening.create(i18n_name: 'scandinavian_defence', session_name: 'scandinavian', first_moves: 'e2e4,d7d5')
puts "seeds finished"
