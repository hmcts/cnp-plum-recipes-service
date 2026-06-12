package uk.gov.hmcts.reform.rhubarb.recipes.data;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class RecipeDataSeeder implements ApplicationRunner {

    private static final Logger LOGGER = LoggerFactory.getLogger(RecipeDataSeeder.class);

    private final NamedParameterJdbcTemplate jdbcTemplate;
    private final RecipeSeedProperties seedProperties;

    public RecipeDataSeeder(NamedParameterJdbcTemplate jdbcTemplate, RecipeSeedProperties seedProperties) {
        this.jdbcTemplate = jdbcTemplate;
        this.seedProperties = seedProperties;
    }

    @Override
    public void run(ApplicationArguments args) {
        Integer recipeCount = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM recipe",
            new MapSqlParameterSource(),
            Integer.class
        );

        if (recipeCount != null && recipeCount > 0) {
            LOGGER.info("Recipe table already has {} rows. Skipping seed.", recipeCount);
            return;
        }

        MapSqlParameterSource params = new MapSqlParameterSource()
            .addValue("id", seedProperties.getId())
            .addValue("userId", seedProperties.getUserId())
            .addValue("name", seedProperties.getName())
            .addValue("ingredients", seedProperties.getIngredients())
            .addValue("method", seedProperties.getMethod());

        jdbcTemplate.update(
            """
            INSERT INTO recipe (id, user_id, name, ingredients, method)
            VALUES (:id, :userId, :name, :ingredients, :method)
            ON CONFLICT (id) DO NOTHING
            """,
            params
        );

        LOGGER.info("Seed recipe ensured for id={}", seedProperties.getId());
    }
}