data "google_service_account" "iac" {
  account_id = var.iac_service_account
}

# Zmiana nazwy workload_identity_pool_id na unikalną, aby uniknąć konfliktu z istniejącym zasobem
resource "google_iam_workload_identity_pool" "tbd-workload-identity-pool" {
  workload_identity_pool_id = "github-actions-pool-unique" # Unikalna nazwa, aby uniknąć konfliktu
}

resource "google_iam_workload_identity_pool_provider" "tbd-workload-identity-provider" {
  #checkov:skip=CKV_GCP_125: "Ensure GCP GitHub Actions OIDC trust policy is configured securely"
  workload_identity_pool_id          = google_iam_workload_identity_pool.tbd-workload-identity-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-provider"
  display_name                       = "GitHub provider"
  description                        = "GitHub identity pool provider for CI/CD purposes"

  # Poprawiona składnia - użycie = zamiast :
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.org"        = "assertion.repository_owner"
    "attribute.refs"       = "assertion.ref"
  }

  attribute_condition = "attribute.org == \"${var.github_org}\""

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "tbd-sa-workload-identity-iam" {
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = data.google_service_account.iac.name
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.tbd-workload-identity-pool.name}/attribute.repository/${var.github_org}/${var.github_repo}"
}
