package uk.gov.hmcts.reform.rhubarb.recipes.endpoint;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import uk.gov.hmcts.reform.rhubarb.recipes.data.RecipeStore;
import uk.gov.hmcts.reform.rhubarb.recipes.domain.Recipe;
import uk.gov.hmcts.reform.rhubarb.recipes.domain.RecipeList;
import uk.gov.hmcts.reform.rhubarb.recipes.exception.NoRecipeFoundException;

import java.util.List;
import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping(
    path = "recipes",
    produces = MediaType.APPLICATION_JSON_VALUE
)
public class RecipeController {

    private final RecipeStore recipeStore; // NOPMD no need for accessors here

    @Value( "${test.sleep}" )
    private long testSleep;

    public RecipeController(RecipeStore recipeStore) {
        this.recipeStore = recipeStore;
    }

    @GetMapping(path = "/{id}")
    @Operation(summary = "Find recipe by ID")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Success"),
        @ApiResponse(responseCode = "404", description = "Not found"),
    })
    public Recipe read(
        @PathVariable String id
    ) {

        return recipeStore
            .read(id)
            .orElseThrow(NoRecipeFoundException::new);
    }

    @GetMapping
    @Operation(summary = "Find all your drafts", description = "Returns an empty array when no drafts were found")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Success"),
    })
    public RecipeList readAll() {

        List<Recipe> recipes = recipeStore.readAll();

        return new RecipeList(recipes);
    }

    @GetMapping(path = "/test")
    @Operation(summary = "Test end point")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Success"),
        @ApiResponse(responseCode = "404", description = "Not found"),
    })
    public String test() throws InterruptedException {

        TimeUnit.SECONDS.sleep(testSleep);
        return "it works";
    }

}
