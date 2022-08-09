Assets {
  Id: 107364086786845811
  Name: "Inventory Object Outline"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 3443521175387742296
      Objects {
        Id: 3443521175387742296
        Name: "Object Outline"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 10361824722656158393
        UnregisteredParameters {
          Overrides {
            Name: "bp:Color A"
            Color {
              R: 1
              G: 1
              B: 1
              A: 0.8
            }
          }
          Overrides {
            Name: "bp:Thickness"
            Float: 2
          }
          Overrides {
            Name: "bp:Outline Channel"
            Int: 20
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Blueprint {
          BlueprintAsset {
            Id: 10569118931248170205
          }
          TeamSettings {
          }
        }
        IsReplicationEnabledByDefault: true
      }
    }
    Assets {
      Id: 10569118931248170205
      Name: "Outline Object"
      PlatformAssetType: 20
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_local_outline"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 118
}
