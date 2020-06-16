package uk.gov.hmcts.reform.rhubarb.recipes;

import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

import static org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.ResultActions;
import static org.springframework.web.context.WebApplicationContext;
import static org.springframework.test.context.junit.jupiter.web.SpringJUnitWebConfig;
import static org.springframework.boot.test.context.SpringBootTest;
import static org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import static org.springframework.beans.factory.annotation.Autowired;
import static org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.BeforeEach;
import static org.junit.jupiter.api.DisplayName;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

@SpringJUnitWebConfig
@SpringBootTest
@AutoConfigureMockMvc
public class SwaggerPublisher {

    private MockMvc mvc;

    @Autowired
    private WebApplicationContext webAppContext;

    @BeforeEach
    public void setup() {
        this.mvc = webAppContextSetup(webAppContext).build();
    }


    @DisplayName("Generate swagger documentation")
    @Test
    @SuppressWarnings("PMD.JUnitTestsShouldIncludeAssert")
    void generateDocs() throws Exception {
        ResultActions perform = mvc.perform(get("/v2/api-docs"));
        byte[] specs = perform
            .andExpect(status().isOk())
            .andReturn()
            .getResponse()
            .getContentAsByteArray();

        try (OutputStream outputStream = Files.newOutputStream(Paths.get("/tmp/swagger-specs.json"))) {
            outputStream.write(specs);
        }

    }
}