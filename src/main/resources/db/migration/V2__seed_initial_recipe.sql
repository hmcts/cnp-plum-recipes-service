INSERT INTO recipe (id, user_id, name, ingredients, method)
VALUES (
  'seed-recipe-1',
  'seed-user',
  'Seeded Tomato Pasta',
  'tomatoes,pasta,olive oil,garlic',
  'Boil pasta. Make sauce. Combine.'
)
ON CONFLICT (id) DO NOTHING;