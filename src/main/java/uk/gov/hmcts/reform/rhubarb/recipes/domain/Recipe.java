package uk.gov.hmcts.reform.rhubarb.recipes.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Recipe {

    private final String id;
    @JsonIgnore
    private final String userId;
    private final String name;
    private final String ingredients;
    private final String method;

    public Recipe(
        String id,
        String userId,
        String name,
        String ingredients,
        String method
    ) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.ingredients = ingredients;
        this.method = method;
    }

    public String getId() {
        return id;
    }

    public String getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }

    public String getIngredients() {
        return ingredients;
    }

    public String getMethod() {
        return method;
    }
}
