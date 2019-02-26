package uk.gov.hmcts.reform.rhubarb.recipes.endpoint;

import com.google.common.base.Strings;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import uk.gov.hmcts.reform.rhubarb.recipes.data.RecipeStore;
import uk.gov.hmcts.reform.rhubarb.recipes.domain.ErrorResult;
import uk.gov.hmcts.reform.rhubarb.recipes.domain.Recipe;
import uk.gov.hmcts.reform.rhubarb.recipes.domain.RecipeList;
import uk.gov.hmcts.reform.rhubarb.recipes.exception.NoPropertyFoundException;
import uk.gov.hmcts.reform.rhubarb.recipes.exception.NoRecipeFoundException;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping(
    path = "recipes",
    produces = MediaType.APPLICATION_JSON_VALUE
)
public class RecipeController {

    private final RecipeStore recipeStore;

    public RecipeController(RecipeStore recipeStore) {
        this.recipeStore = recipeStore;
    }

    @GetMapping(path = "/{id}")
    @ApiOperation("Find recipe by ID")
    @ApiResponses({
        @ApiResponse(code = 200, message = "Success"),
        @ApiResponse(code = 404, message = "Not found", response = ErrorResult.class),
    })
    public Recipe read(
        @PathVariable String id
    ) {

        return recipeStore
            .read(id)
            .orElseThrow(NoRecipeFoundException::new);
    }

    @GetMapping
    @ApiOperation(value = "Find all your drafts", notes = "Returns an empty array when no drafts were found")
    @ApiResponses({
        @ApiResponse(code = 200, message = "Success"),
    })
    public RecipeList readAll(
        @RequestParam(required = false) Map<String, String> params
    ) {

        List<Recipe> recipes = recipeStore.readAll();

        return new RecipeList(recipes);
    }

    @GetMapping(path = "/testproperties")
    @ApiOperation(value = "Return sha256 of test property", notes = "Returns an empty string when no property value found")
    @ApiResponses({
        @ApiResponse(code = 200, message = "Success"),
    })
    public String readTestProperty(
        @Value("${cnp-core-infra.test}") String testProp,
        @Value("${CORE_INFRA_TEST}") String testPropAlias,
        @Value("${external.test}") String testPropRef
    ) {
        if (Strings.isNullOrEmpty(testProp)) {
            throw new NoPropertyFoundException("cnp-core-infra.test not found");
        }
        if (Strings.isNullOrEmpty(testPropAlias)) {
            throw new NoPropertyFoundException("CORE_INFRA_TEST not found");
        }
        if (Strings.isNullOrEmpty(testPropRef)) {
            throw new NoPropertyFoundException("external.test not found");
        }
        return "Found values for cnp-core-infra.test, CORE_INFRA_TEST and external.test";
    }

}
