/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Static IP for the broker
resource "google_compute_global_address" "ingress" {
  project = var.project_id
  name    = var.name
}

# Cloud endpoints for DNS
module "cloud-ep-dns" {
  # Return to module registry after this is merged: https://github.com/terraform-google-modules/terraform-google-endpoints-dns/pull/2
  #source      = "terraform-google-modules/endpoints-dns/google"
  source      = "github.com/danisla/terraform-google-endpoints-dns?ref=0.12upgrade"
  project     = var.project_id
  name        = var.name
  external_ip = google_compute_global_address.ingress.address
}