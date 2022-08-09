Assets {
  Id: 2329109797828125445
  Name: "Thrown Item Effect Destroyed"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 1980762014367768270
      Objects {
        Id: 1980762014367768270
        Name: "Thrown Item Effect Destroyed"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 2237278166346986589
        Lifespan: 1
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        NetworkContext {
          MinDetailLevel {
            Value: "mc:edetaillevel:low"
          }
          MaxDetailLevel {
            Value: "mc:edetaillevel:ultra"
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:medium"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 2237278166346986589
        Name: "Impact Sparks VFX"
        Transform {
          Location {
            Z: 9.59225082
          }
          Rotation {
          }
          Scale {
            X: 0.477916181
            Y: 0.477916181
            Z: 0.477916181
          }
        }
        ParentId: 1980762014367768270
        UnregisteredParameters {
          Overrides {
            Name: "bp:Particle Scale Multiplier"
            Float: 0.1
          }
          Overrides {
            Name: "bp:Spark Line Scale Multiplier"
            Float: 0.658060133
          }
          Overrides {
            Name: "bp:Enable Hotspot"
            Bool: false
          }
          Overrides {
            Name: "bp:Enable Flash"
            Bool: false
          }
          Overrides {
            Name: "bp:Color"
            Color {
              R: 0.991102397
              G: 0.496933132
              B: 0.168269426
              A: 1
            }
          }
          Overrides {
            Name: "bp:Gravity"
            Float: -2.93869829
          }
          Overrides {
            Name: "bp:Density"
            Float: 1.69737542
          }
          Overrides {
            Name: "bp:Initial Velocity"
            Vector {
              X: 300
              Y: 300
              Z: 500
            }
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
            Id: 7357786651578077317
          }
          TeamSettings {
          }
          Vfx {
            AutoPlay: true
          }
        }
        Relevance {
          Value: "mc:eproxyrelevance:medium"
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
    }
    Assets {
      Id: 7357786651578077317
      Name: "Impact Sparks VFX"
      PlatformAssetType: 8
      PrimaryAsset {
        AssetType: "VfxBlueprintAssetRef"
        AssetId: "fxbp_impact_sparks"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 118
  VirtualFolderPath: "Inventory System"
  VirtualFolderPath: "Item Effects"
}
