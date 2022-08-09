Assets {
  Id: 5848822719085026840
  Name: "Rock Pickup"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 892841105518164554
      Objects {
        Id: 892841105518164554
        Name: "Rock Pickup"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 13566479696548412767
        ChildIds: 11122035206489545276
        ChildIds: 14201220185890344818
        UnregisteredParameters {
          Overrides {
            Name: "cs:Inventory_Pickup"
            AssetReference {
              Id: 8099296177848779074
            }
          }
          Overrides {
            Name: "cs:PickupTrigger"
            ObjectReference {
              SubObjectId: 12301085744461862979
            }
          }
          Overrides {
            Name: "cs:Item"
            ObjectReference {
              SubObjectId: 14615357257194208942
            }
          }
          Overrides {
            Name: "cs:UpDownCurve"
            SimpleCurve {
              Keys {
                Interpolation {
                  Value: "mc:erichcurveinterpmode:rcim_cubic"
                }
                TangentMode {
                  Value: "mc:erichcurvetangentmode:rctm_user"
                }
              }
              Keys {
                Interpolation {
                  Value: "mc:erichcurveinterpmode:rcim_cubic"
                }
                TangentMode {
                  Value: "mc:erichcurvetangentmode:rctm_user"
                }
                Time: 3
                Value: 1
              }
              PreExtrapolation {
                Value: "mc:erichcurveextrapolation:rcce_oscillate"
              }
              PostExtrapolation {
                Value: "mc:erichcurveextrapolation:rcce_oscillate"
              }
              DefaultValue: 3.40282347e+38
            }
          }
          Overrides {
            Name: "cs:Rotate"
            Bool: true
          }
          Overrides {
            Name: "cs:AnimateUpDown"
            Bool: true
          }
          Overrides {
            Name: "cs:multiplier"
            Float: 50
          }
          Overrides {
            Name: "cs:Outline"
            ObjectReference {
              SubObjectId: 6213822771200744947
            }
          }
          Overrides {
            Name: "cs:OutlineTrigger"
            ObjectReference {
              SubObjectId: 11900380414139593647
            }
          }
          Overrides {
            Name: "cs:Inventory_Pickup:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:Inventory_Pickup:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:PickupTrigger:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:PickupTrigger:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:Item:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:Item:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:UpDownCurve:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:UpDownCurve:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:Rotate:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:Rotate:ml"
            Bool: false
          }
          Overrides {
            Name: "cs:AnimateUpDown:isrep"
            Bool: false
          }
          Overrides {
            Name: "cs:AnimateUpDown:ml"
            Bool: false
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
        Folder {
          IsGroup: true
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 13566479696548412767
        Name: "Inventory_Pickup_Default"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 892841105518164554
        UnregisteredParameters {
          Overrides {
            Name: "cs:Root"
            ObjectReference {
              SubObjectId: 892841105518164554
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
        Script {
          ScriptAsset {
            Id: 7153229304768253401
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 11122035206489545276
        Name: "Client"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 892841105518164554
        ChildIds: 17087498849124234912
        ChildIds: 14615357257194208942
        ChildIds: 7784399501063660353
        ChildIds: 16710573450966939790
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
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 17087498849124234912
        Name: "Inventory Object Outline"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 11122035206489545276
        TemplateInstance {
          ParameterOverrideMap {
            key: 3443521175387742296
            value {
              Overrides {
                Name: "Name"
                String: "Inventory Object Outline"
              }
              Overrides {
                Name: "Position"
                Vector {
                }
              }
              Overrides {
                Name: "Rotation"
                Rotator {
                }
              }
              Overrides {
                Name: "bp:Object To Outline"
                ObjectReference {
                  SubObjectId: 14615357257194208942
                }
              }
              Overrides {
                Name: "bp:Enabled"
                Bool: false
              }
              Overrides {
                Name: "bp:Dynamic Thickness"
                Bool: false
              }
              Overrides {
                Name: "bp:Thickness"
                Float: 1
              }
            }
          }
          TemplateAsset {
            Id: 107364086786845811
          }
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 14615357257194208942
        Name: "Item"
        Transform {
          Location {
            Z: 18.0671272
          }
          Rotation {
          }
          Scale {
            X: 0.236841708
            Y: 0.236841708
            Z: 0.236841708
          }
        }
        ParentId: 11122035206489545276
        ChildIds: 333727517151418205
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
        Folder {
          IsGroup: true
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 333727517151418205
        Name: "Rock 03"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 0.708986282
            Y: 0.708986282
            Z: 0.708986282
          }
        }
        ParentId: 14615357257194208942
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
        CoreMesh {
          MeshAsset {
            Id: 3505030211301950134
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          StaticMesh {
            Physics {
              Mass: 100
              LinearDamping: 0.01
            }
            BoundsScale: 1
          }
        }
        Relevance {
          Value: "mc:eproxyrelevance:critical"
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 7784399501063660353
        Name: "Outline Trigger"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 11122035206489545276
        TemplateInstance {
          ParameterOverrideMap {
            key: 17259491069621030325
            value {
              Overrides {
                Name: "Name"
                String: "Outline Trigger"
              }
            }
          }
          TemplateAsset {
            Id: 16799078388953106667
          }
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 16710573450966939790
        Name: "Inventory_Pickup_Client"
        Transform {
          Location {
            X: -251.960754
            Y: -508.493378
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 11122035206489545276
        UnregisteredParameters {
          Overrides {
            Name: "cs:Outline"
            ObjectReference {
              SubObjectId: 6213822771200744947
            }
          }
          Overrides {
            Name: "cs:OutlineTrigger"
            ObjectReference {
              SubObjectId: 11900380414139593647
            }
          }
          Overrides {
            Name: "cs:Item"
            ObjectReference {
              SubObjectId: 14615357257194208942
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
        Script {
          ScriptAsset {
            Id: 16570813441883333925
          }
        }
        NetworkRelevanceDistance {
          Value: "mc:eproxyrelevance:critical"
        }
        IsReplicationEnabledByDefault: true
      }
      Objects {
        Id: 14201220185890344818
        Name: "Pickup Trigger"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 892841105518164554
        TemplateInstance {
          ParameterOverrideMap {
            key: 2859771732851525319
            value {
              Overrides {
                Name: "Name"
                String: "Pickup Trigger"
              }
            }
          }
          TemplateAsset {
            Id: 12185415287135871786
          }
        }
        IsReplicationEnabledByDefault: true
      }
    }
    Assets {
      Id: 3505030211301950134
      Name: "Rock 03"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_rock_generic_003"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 118
  VirtualFolderPath: "Inventory System"
  VirtualFolderPath: "Item Templates"
}
