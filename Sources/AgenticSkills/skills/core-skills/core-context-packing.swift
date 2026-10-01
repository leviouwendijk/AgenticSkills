import Agentic
import AgenticIO

public extension CoreSkillProvider {
    static let contextPacking = AgentSkill(
        identifier: "context-packing",
        name: "Context packing",
        summary: "Collect only the context needed for the current task, with clear provenance.",
        body: """
        Build context deliberately instead of loading broad file blobs.

        Workflow:
        1. Start from the user request and identify the smallest facts needed to answer or act.
        2. Narrow context through deterministic discovery before loading broad source material.
        3. Use `\(SystemIO.Tools.FindPaths.identifier.rawValue)` to rank likely files or directories by path when the target is not already known.
        4. Use `\(SystemIO.Tools.SearchSources.identifier.rawValue)` to locate relevant implementation or text ranges inside the authorized source universe.
        5. Use `\(SystemIO.Tools.LoadSearchContext.identifier.rawValue)` to admit the strongest search candidates as bounded exact source context with freshness validation.
        6. Use `\(SystemIO.Tools.ScanPaths.identifier.rawValue)` when filesystem topology or exhaustive enumeration itself is needed.
        7. Use `\(SystemIO.Tools.ReadFile.identifier.rawValue)` when the exact file and useful range are already known, or when a deliberate broader direct read is justified.
        8. Keep source boundaries visible: path, line range, and why that source matters.
        9. Separate durable task facts from incidental surrounding text.
        10. When context is incomplete, name the missing fact and the next smallest retrieval that would resolve it.

        Packing priorities:
        - User’s current objective.
        - Relevant current files or snippets.
        - Prior decisions that constrain the change.
        - Existing conventions in nearby code or documents.
        - Tool results that affect correctness.

        Avoid:
        - Loading whole files because a narrow range would do.
        - Keeping stale context after newer tool output contradicts it.
        - Mixing unrelated project background into the active task context.
        """,
        metadata: .init(
            domains: [
                .core
            ],
            tools: .init(
                optional: [
                    .tool(SystemIO.Tools.FindPaths.identifier),
                    .tool(SystemIO.Tools.SearchSources.identifier),
                    .tool(SystemIO.Tools.LoadSearchContext.identifier),
                    .tool(SystemIO.Tools.ScanPaths.identifier),
                    .tool(SystemIO.Tools.ReadFile.identifier)
                ]
            ),
            tags: [
                "core",
                "context",
                "retrieval"
            ],
            attributes: [
                "pack": "base",
                "kind": "workflow"
            ]
        )
    )
}
