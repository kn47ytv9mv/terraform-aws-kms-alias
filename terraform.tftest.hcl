mock_provider "aws" {
}

run "rejects_alias_prefix_in_name" {
  command = plan

  variables {
    name          = "alias/my-app-key"
    target_key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
  }

  expect_failures = [var.name]
}

run "name_gets_alias_prefix_added" {
  command = plan

  variables {
    name          = "my-app-key"
    target_key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
  }

  assert {
    condition     = aws_kms_alias.resource.name == "alias/my-app-key"
    error_message = "name should have 'alias/' prepended automatically."
  }
}

run "target_key_id_passes_through" {
  command = plan

  variables {
    name          = "my-app-key"
    target_key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
  }

  assert {
    condition     = aws_kms_alias.resource.target_key_id == "1234abcd-12ab-34cd-56ef-1234567890ab"
    error_message = "target_key_id should pass through unchanged."
  }
}

run "no_name_falls_back_to_random_uuid" {
  command = apply

  variables {
    target_key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
  }

  assert {
    condition     = aws_kms_alias.resource.name == "alias/${random_uuid.resource.id}"
    error_message = "Leaving name unset should fall back to 'alias/' plus the generated random_uuid."
  }
}

run "readme_default_example" {
  command = plan

  variables {
    name          = "my-app-key"
    target_key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
  }
}
